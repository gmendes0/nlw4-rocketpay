defmodule RocketpayWeb.UsersView do
  alias Rocketpay.{Account, User}

  def render("create.json", %{user: %User{account: %Account{} = account} = user}) do
    user_map =
      user
      |> Map.drop([:__meta__, :__struct__, :account, :password])

    account_map =
      account
      |> Map.drop([:__meta__, :__struct__, :user])

    user_map
    |> Map.put(:account, account_map)

    # %{
    #   data:
    #     user
    #     |> Map.delete(:__meta__)
    #     |> Map.delete(:__struct__)
    #     |> Map.delete(:password)
    # }.data
  end
end
