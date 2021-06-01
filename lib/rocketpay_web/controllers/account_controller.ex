defmodule RocketpayWeb.AccountController do
  use RocketpayWeb, :controller

  alias Rocketpay.Schemas.Account

  action_fallback RocketpayWeb.FallbackController

  def deposit(conn, params) do
    case Rocketpay.deposit(params) do
      {:ok, %Account{} = account} ->
        conn
        |> put_status(:ok)
        |> render("update.json", account: account)

      {:error, result} ->
        conn
        |> put_status(:bad_request)
        |> put_view(RocketpayWeb.ErrorView)
        |> render("400.json", result: result)
    end
  end

  def withdraw(conn, params) do
    case Rocketpay.withdraw(params) do
      {:ok, %Account{} = account} ->
        conn
        |> put_status(:ok)
        |> render("update.json", account: account)

      {:error, result} ->
        conn
        |> put_status(:bad_request)
        |> put_view(RocketpayWeb.ErrorView)
        |> render("400.json", result: result)
    end
  end

  def transfer(conn, params) do
    case Rocketpay.transfer(params) do
      {:ok, %Account{} = account} ->
        conn
        |> put_status(:ok)
        |> render("transfer.json", account: account)

      {:error, result} ->
        conn
        |> put_status(:bad_request)
        |> put_view(RocketpayWeb.ErrorView)
        |> render("400.json", result: result)
    end
  end
end
