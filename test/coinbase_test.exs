defmodule CoinbaseTest do
  use ExUnit.Case
  doctest Coinbase

  def fixture do

  end

  test "test config/0" do
    assert !is_nil(Coinbase.config())
  end

end
