defmodule Rocketpay.UseCases.Operation do
  alias Rocketpay.Schemas.Account

  def call(%{"id" => id, "value" => value}, operation_name) do
    account_operation = account_operation_name(operation_name)

    Ecto.Multi.new()
    |> Ecto.Multi.run(account_operation, fn repo, _changes ->
      case repo.get(Account, id) do
        nil -> {:error, "Account not found!"}
        account -> {:ok, account}
      end
    end)
    |> Ecto.Multi.run(operation_name, fn repo, changes ->
      account = Map.get(changes, account_operation)

      case operation(account, value, operation_name) do
        {:error, _reason} = error ->
          error

        new_balance ->
          account
          |> Account.changeset(%{balance: new_balance})
          |> repo.update()
      end
    end)
  end

  defp operation(%Account{balance: balance}, value, :deposit) do
    case Decimal.cast(value) do
      {:ok, value} -> Decimal.add(balance, value)
      :error -> {:error, "Invalid deposit value!"}
    end
  end

  defp operation(%Account{balance: balance}, value, :withdraw) do
    case Decimal.cast(value) do
      {:ok, value} -> Decimal.sub(balance, value)
      :error -> {:error, "Invalid withdraw value!"}
    end
  end

  defp account_operation_name(operation) do
    "account_#{Atom.to_string(operation)}"
    |> String.to_atom()
  end
end
