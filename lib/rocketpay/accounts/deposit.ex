defmodule Rocketpay.Accounts.Deposit do
  alias Rocketpay.{Repo}
  alias Rocketpay.Accounts.Operation

  def call(%{"id" => _id, "value" => _value} = params) do
    Operation.call(params, :deposit)
    |> run_transaction()
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} ->
        {:error, reason}

      {:ok, %{update_balance: account}} ->
        {:ok, account}
    end
  end
end