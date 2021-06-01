defmodule Rocketpay.UseCases.Transfer do
  alias Rocketpay.UseCases.Operation

  def call(%{"id" => from_id, "to" => to_id, "value" => value}) do
    withdraw_params = build_params(from_id, value)
    deposit_params = build_params(to_id, value)

    Ecto.Multi.new()
    |> Ecto.Multi.merge(fn _changes -> Operation.call(withdraw_params, :withdraw) end)
    |> Ecto.Multi.merge(fn _changes -> Operation.call(deposit_params, :deposit) end)
    |> run_transaction()
  end

  defp run_transaction(operation) do
    case Rocketpay.Repo.transaction(operation) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{withdraw: account}} -> {:ok, account}
    end
  end

  defp build_params(id, value), do: %{"id" => id, "value" => value}
end
