defmodule Coinbase.Http do
  @moduledoc """
  Helper functions to interact with Coinbase V2 REST API.

  Handles the signing and configuring the headers with required properties like
  CB-ACCESS-KEY, CB-ACCESS-SIGN, CB-VERSION, and CB-ACCESS-TIMESTAMP.
  CB-VERSION value set in configuration.
  See https://developers.coinbase.com/docs/wallet/api-key-authentication.
  """

  @doc """
  Construct a generic PUT request with specified URL path and body.
  Returns decoded body only.
  """
  def update!(url_path, body) when is_map(body) do
    case update(url_path, body) do
      {:error, error} -> error.reason
      {:ok, %{status_code: 200} = response} -> response.body |> Poison.decode!()
      {_, msg} -> msg.body |> Poison.decode!()
    end
  end

  @doc """
  Construct a generic PUT request with specified URL path and body.
  Returns decoded body only.
  """
  def update(url_path, body) when is_map(body) do
    body = Poison.encode!(body)
    {url, headers, options} = build_request("PUT", url_path, body)
    HTTPoison.put(url, body, headers, options)
  end

  @doc """
  Construct a generic DELETE request with the specified path.
  """
  def delete(url_path) do
    {url, headers, options} = build_request("DELETE", url_path)
    HTTPoison.delete(url, headers, options)
  end

  @doc """
  Construct a generic POST request with specified URL path and body.
  Returns decoded body only.
  """
  def post!(url_path, body) when is_map(body) do
    case post(url_path, body) do
      {:error, error} -> error.reason
      {:ok, %{status_code: 200} = response} -> response.body |> Poison.decode!()
      {_, msg} -> msg.body |> Poison.decode!()
    end
  end

  @doc """
  Construct generic POST request with specified URL path and body.
  Returns full HTTPoison response.
  """
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
    key     = Application.get_env(:coinbase_ex, :api_key)
    secret  = Application.get_env(:coinbase_ex, :api_secret)
    version = Application.get_env(:coinbase_ex, :version)
    ts      = inspect(:os.system_time(:seconds))
    url     = Application.get_env(:coinbase_ex, :api_url) <> url_path
    msg     = "#{ts}#{method}#{url_path}#{body}"
    sign    = :crypto.hmac(:sha256, secret, msg) |> Base.encode16(case: :lower)
    headers = [{"Content-Type", "application/json"},
    {"CB-ACCESS-KEY", key}, {"CB-ACCESS-SIGN", sign},
    {"CB-ACCESS-TIMESTAMP", ts}, {"CB-VERSION", version}]
    options = [ssl: [{:versions, [:'tlsv1.2']}], recv_timeout: 5000]
    {url, headers, options}
  end

end
