defmodule Rocketpay.Accounts.Withdraw do
  alias Rocketpay.{Repo}
  alias Rocketpay.Accounts.Operation

  def call(%{"id" => _id, "value" => _value} = params) do
    Operation.call(params, :withdraw)
    |> run_transaction()
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _failed_operation, failed_value, _changes_so_far} ->
        {:error, failed_value}

      {:ok, %{update_balance: account}} ->
        {:ok, account}
    end
  end
end
