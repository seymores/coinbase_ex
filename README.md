# coinbase_ex

An easy way to buy, send, and accept bitcoin through the [Coinbase API](https://developers.coinbase.com).  
This library supports both the [API key authentication](https://developers.coinbase.com/docs/wallet/api-key-authentication) method only for now.

## Usage

### Market Data

Get supported native currencies

```elixir
Coinbase.get_currencies()
```

Get buy price

```elixir
Coinbase.get_buy_price("BTC-MYR")
```


## Configuration
Please configure your API key and secret in your config file, see dev.secret.exs_sample.

```elixir
config :coinbase_ex, api_key: "YOUR_API_KEY",
                  api_secret: "YOUR_API_SECRET",
                  api_url: "https://api.coinbase.com",
                  version: "2016-08-10"
```

## Installation
Install from this github repo directly for now.

```elixir
def deps do
  [{:coinbase_ex, github: "seymores/coinbase_ex"}]
end
```

