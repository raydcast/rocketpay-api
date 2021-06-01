defmodule Rocketpay.UseCases.Deposit do
  alias Rocketpay.UseCases.Operation

  def call(params) do
    params
    |> Operation.call(:deposit)
    |> run_transaction()
  end

  defp run_transaction(operation) do
    case Rocketpay.Repo.transaction(operation) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{deposit: account}} -> {:ok, account}
    end
  end
end
