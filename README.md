# coinbase_ex

An easy way to buy, send, and accept bitcoin through the [Coinbase API](https://developers.coinbase.com).  
This library supports both the [API key authentication](https://developers.coinbase.com/docs/wallet/api-key-authentication) method only for now.

## Usage

#### Time
Get Coinbase current time.

```elixir
Coinbase.current_time()
{"data" => %{"epoch" => 1497185372, "iso" => "2017-06-11T12:49:32Z"}}
```

### Market Data

Get supported native currencies

```elixir
Coinbase.get_currencies()
%{"data" => [%{"id" => "AED", "min_size" => "0.01000000",
     "name" => "United Arab Emirates Dirham"},
   %{"id" => "AFN", "min_size" => "0.01000000", "name" => "Afghan Afghani"},
   %{"id" => "ALL", "min_size" => "0.01000000", "name" => "Albanian Lek"},
    %{"id" => "FJD", "min_size" => "0.01000000", ...}, %{"id" => "FKP", ...},
   %{...}, ...]}
```

Get buy price

```elixir
Coinbase.get_buy_price("BTC-MYR")
%{"data" => %{"amount" => "12500.29", "currency" => "MYR"}}
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

