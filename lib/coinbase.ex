defmodule Coinbase do
  @moduledoc """
  #todo
  """

  @doc """
    Create new Bitcoin account with specified name.
  """
  def create_account(name, currency) do
    data = %{name: name, currency: currency}
    post!("/v2/accounts", data)
  end

  def update_account(id, data) when is_map(data) do
     update!("/v2/accounts/#{id}", data)
  end

  @doc """
    Delete account with the specified name.
  """
  def delete_account(id) do
    case delete("/v2/accounts/#{id}") do
      {:error, err} -> err.reason
      {:ok, %{status_code: 204} = response} -> true
      {_, response} -> false
    end
  end

  @doc """
    Get current user information according to
    https://developers.coinbase.com/api/v2?shell#show-current-user.
  """
  def user do
    get("/v2/user")
  end

  def update!(url_path, body) when is_map(body) do
    case update(url_path, body) do
      {:error, error} -> error.reason
      {:ok, %{status_code: 200} = response} -> response.body |> Poison.decode!()
      {_, msg} -> msg.body |> Poison.decode!()
    end
  end

  def update(url_path, body) when is_map(body) do
    body = Poison.encode!(body)
    {url, headers, options} = build_request("PUT", url_path, body)
    HTTPoison.put(url, body, headers, options)
  end

  def delete(url_path) do
    {url, headers, options} = build_request("DELETE", url_path)
    HTTPoison.delete(url, headers, options)
  end

  def post!(url_path, body) when is_map(body) do
    case post(url_path, body) do
      {:error, error} -> error.reason
      {:ok, %{status_code: 200} = response} -> response.body |> Poison.decode!()
      {_, msg} -> msg.body |> Poison.decode!()
    end
  end

  def post(url_path, body) when is_map(body) do
    body = Poison.encode!(body)
    {url, headers, options} = build_request("POST", url_path, body)
    HTTPoison.post(url, body, headers, options)
  end

  @doc """
    Construct generic GET request with specified URL path.
    Returns full HTTPoison response.
  """
  def get(url_path) do
    {url, headers, options} = build_request("GET", url_path)
    HTTPoison.get(url, headers, options)
  end

  @doc """
    Construct generic GET request with specified URL path.
    Returns response body only.
  """
  def get!(url_path) do
    case get(url_path) do
      {:error, error} -> error.reason
      {:ok, %{status_code: 200} = response} -> response.body |> Poison.decode!()
      {_, msg} -> msg.body |> Poison.decode!()
    end
  end

  @doc """
    Handles the signing and configuring the headers with required properties like
    CB-ACCESS-KEY, CB-ACCESS-SIGN, CB-VERSION, and CB-ACCESS-TIMESTAMP.
    CB-VERSION value set in configuration.
    See https://developers.coinbase.com/docs/wallet/api-key-authentication.
  """
  defp build_request(method, url_path, body \\ "") do
    key     = Application.get_env(:coinbase, :api_key)
    secret  = Application.get_env(:coinbase, :api_secret)
    version = Application.get_env(:coinbase, :version)
    ts      = inspect(:os.system_time(:seconds))
    msg     = "#{ts}#{method}#{url_path}#{body}"
    sign = :crypto.hmac(:sha256, secret, msg) |> Base.encode16(case: :lower)
    headers = [{"Content-Type", "application/json"},
               {"CB-ACCESS-KEY", key}, {"CB-ACCESS-SIGN", sign},
               {"CB-ACCESS-TIMESTAMP", ts}, {"CB-VERSION", version}]
    options = [ssl: [{:versions, [:'tlsv1.2']}], recv_timeout: 5000]
    url     = Application.get_env(:coinbase, :api_url) <> url_path
    {url, headers, options}
  end

end
