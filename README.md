# coinbase_ex

An easy way to buy, send, and accept bitcoin through the [Coinbase API](https://developers.coinbase.com).  
This library supports both the [API key authentication](https://developers.coinbase.com/docs/wallet/api-key-authentication) method only for now.

## Usage

### Market Data

Get supported native currencies

```
Coinbase.get_currencies()
```

Get buy price

```
Coinbase.get_buy_price("BTC-MYR")
```


## Configuration
Please configure your API key and secret in your config file, see dev.secret.exs_sample.

```
config :coinbase, api_key: "YOUR_API_KEY",
                  api_secret: "YOUR_API_SECRET",
                  api_url: "https://api.coinbase.com",
                  version: "2016-08-10"
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `coinbase` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:coinbase, "~> 0.1.0"}]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/coinbase](https://hexdocs.pm/coinbase).

