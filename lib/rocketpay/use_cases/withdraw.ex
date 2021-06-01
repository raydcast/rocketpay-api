defmodule Rocketpay.UseCases.Withdraw do
  alias Rocketpay.UseCases.Operation

  def call(params) do
    params
    |> Operation.call(:withdraw)
    |> run_transaction()
  end

  defp run_transaction(operation) do
    case Rocketpay.Repo.transaction(operation) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{withdraw: account}} -> {:ok, account}
    end
  end
end
