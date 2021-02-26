defmodule RocketpayWeb.AccountView do
  alias Rocketpay.Account

  def render("update.json", %{account: %Account{} = account}) do
    account
    |> Map.drop([:__meta__, :__struct__, :user])
  end
end
