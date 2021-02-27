defmodule RocketpayWeb.AccountView do
  alias Rocketpay.Account
  alias Rocketpay.Transactions.Response, as: TransactionResponse

  def render("update.json", %{account: %Account{} = account}) do
    account
    |> Map.drop([:__meta__, :__struct__, :user])
  end

  def render("transaction.json", %{
        transaction: %TransactionResponse{sender: sender, receiver: receiver}
      }) do
    %{
      sender:
        sender
        |> Map.drop([:__meta__, :__struct__, :user]),
      receiver:
        receiver
        |> Map.drop([:__meta__, :__struct__, :user])
    }
  end
end
