defmodule Rocketpay.Accounts.Transaction do
  alias Ecto.Multi
  alias Rocketpay.Repo
  alias Rocketpay.Accounts.Operation

  def call(%{"from" => sender_id, "to" => receiver_id, "value" => value}) do
    withdraw_params = build_params(sender_id, value)
    deposit_params = build_params(receiver_id, value)

    Multi.new()
    |> Multi.merge(fn _changes_so_far -> Operation.call(withdraw_params, :withdraw) end)
    |> Multi.merge(fn _changes_so_far -> Operation.call(deposit_params, :deposit) end)
    |> run_transaction()
  end

  defp build_params(id, value), do: %{"id" => id, "value" => value}

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _failed_operation, failed_value, _changes_so_far} ->
        {:error, failed_value}

      {:ok, %{withdraw: sender_account, deposit: receiver_account}} ->
        {:ok, %{sender: sender_account, receiver: receiver_account}}
    end
  end
end
