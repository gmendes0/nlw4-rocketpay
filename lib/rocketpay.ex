defmodule Rocketpay do
  @moduledoc """
  Rocketpay keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias Rocketpay.Users.Create, as: UsersCreate
  alias Rocketpay.Accounts.{Deposit, Withdraw, Transaction}

  defdelegate create_user(params), to: UsersCreate, as: :call
  defdelegate deposit(params), to: Deposit, as: :call
  defdelegate withdraw(params), to: Withdraw, as: :call
  defdelegate transaction(params), to: Transaction, as: :call
end
