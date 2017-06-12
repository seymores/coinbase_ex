# coinbase_ex

An easy way to buy, send, and accept bitcoin through the [Coinbase API](https://developers.coinbase.com).  
This library supports both the [API key authentication](https://developers.coinbase.com/docs/wallet/api-key-authentication) method only for now.

## Usage

### Current user
Get the current user information.

```elixir
Coinbase.current_user()
%{"data" => %{"avatar_url" => "https://images.coinbase.com/avatar?xxxxx",
    "bitcoin_unit" => "BTC",
    "country" => %{...},
    "created_at" => "2016-08-03T13:17:07Z", "email" => "...",
    "id" => "...", "name" => "Me me me",
    "native_currency" => "...", "profile_bio" => nil, "profile_location" => nil,
    "profile_url" => nil, "resource" => "user", "resource_path" => "/v2/user",
    "state" => nil, "time_zone" => "USA", "username" => nil}}
```

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

### Account

List all accounts under the current user.

```elixir
Coinbase.accounts()
%{"data" => [...], "pagination" => %{...}}
```

Create new account

```elixir
Coinbase.create_account("Temp Wallet Account")
%{"data" => %{"balance" => %{"amount" => "0.00000000", "currency" => "BTC"},
    "created_at" => "2017-06-11T23:32:13Z", "currency" => "BTC",
    "id" => "xxx__xxx",
    "name" => "Temp Wallet Account",
    "native_balance" => %{"amount" => "0.00", "currency" => "USD"},
    "primary" => false, "resource" => "account",
    "resource_path" => "/v2/accounts/xxx__xxx",
    "type" => "wallet", "updated_at" => "2017-06-11T23:32:13Z"}}
```

Update account.
The current API only allows update of name.

```elixir
Coinbase.update_account("xxx-yyyy-zzz-yyy-xxx", %{name: "New name for the account"})
```

Delete account by ID.

```elixir
Coinbase.delete_account("xxx-yyyy-zzz-yyy-xxx")
true
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

