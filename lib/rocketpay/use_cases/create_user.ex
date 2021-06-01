defmodule Rocketpay.UseCases.CreateUser do
  alias Ecto.Multi
  alias Rocketpay.Schemas.{Account, User}

  def call(params) do
    trx =
      Multi.new()
      |> Multi.insert(:create_user, User.changeset(params))
      |> Multi.run(:create_account, fn repo, %{create_user: user} ->
        create_account(repo, user)
      end)
      |> Multi.run(:preload_data, fn repo, %{create_user: user} ->
        preload_data(repo, user)
      end)
      |> Rocketpay.Repo.transaction()

    case trx do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{preload_data: user}} -> {:ok, user}
    end
  end

  defp create_account(repo, user) do
    %{user_id: user.id, balance: "0.00"}
    |> Account.changeset()
    |> repo.insert()
  end

  defp preload_data(repo, user) do
    {:ok, repo.preload(user, :account)}
  end
end
