defmodule Coinbase do
  @moduledoc """
  #todo
  """
  import Coinbase.Http


  def get_currencies do
    get!("/v2/currencies")
  end

  def get_exchange_rates(currency \\ "BTC") do
    get!("/v2/exchange-rates?currency=#{currency}")
  end

  def get_buy_price(curr_pair) do
    get!("/v2/prices/#{curr_pair}/buy")
  end

  def get_sell_price(curr_pair) do
    get!("/v2/prices/#{curr_pair}/sell")
  end

  def get_spot_price(curr_pair) do
    get!("/v2/prices/#{curr_pair}/spot")
  end

  def current_time do
    get!("/v2/time")
  end

  def current_user do
    get!("/v2/user")
  end

  def accounts do
    get!("/v2/accounts")
  end

  @doc """
    Create new Bitcoin account with specified name.
  """
  def create_account(name, currency \\ "BTC") do
    data = %{name: name, currency: currency}
    post!("/v2/accounts", data)
  end
  
  @doc """
    Create address with name
  """
  def create_address(id, name \\ "") do
    data = %{name: name }
    post!("/v2/accounts/#{id}/addresses", data)
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
      {:ok, %{status_code: 204}} -> true
      {_, _} -> false
    end
  end

  @doc """
    Get current user information according to
    https://developers.coinbase.com/api/v2?shell#show-current-user.
  """
  def user do
    get("/v2/user")
  end

end
