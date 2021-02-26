defmodule Rocketpay.Accounts.Operation do
  alias Ecto.Multi
  alias Rocketpay.{Account}

  def call(%{"id" => id, "value" => value}, operation) do
    operation_name = account_operation_name(operation)

    Multi.new()
    |> Multi.run(operation_name, fn repo, _changes -> get_account(repo, id) end)
    |> Multi.run(operation, fn repo, changes ->
      account = Map.get(changes, operation_name)

      update_balance(repo, account, value, operation)
    end)
  end

  defp get_account(repo, id) do
    case repo.get(Account, id) do
      nil ->
        {:error, "account not found!"}

      %Account{} = account ->
        {:ok, account}
    end
  end

  defp update_balance(repo, account, value, operation) do
    account
    |> sum_values(value, operation)
    |> update_account(repo, account)
  end

  defp sum_values(%Account{balance: balance}, value, operation) do
    value
    |> Decimal.cast()
    |> handle_cast(balance, operation)
  end

  defp handle_cast({:ok, value}, balance, :deposit), do: {:ok, Decimal.add(balance, value)}
  defp handle_cast({:ok, value}, balance, :withdraw), do: {:ok, Decimal.sub(balance, value)}
  defp handle_cast(:error, _balance, _operation), do: {:error, "invalid deposit value"}

  defp update_account({:error, _reason} = error, _repo, _account), do: error

  defp update_account({:ok, value}, repo, %Account{} = account) do
    account
    |> Account.changeset(%{balance: value})
    |> repo.update()
  end

  defp account_operation_name(operation) do
    "account_#{Atom.to_string(operation)}"
    |> String.to_atom()
  end
end
