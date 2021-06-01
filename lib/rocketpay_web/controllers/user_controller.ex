defmodule RocketpayWeb.UserController do
  use RocketpayWeb, :controller

  alias Rocketpay.Schemas.User

  action_fallback RocketpayWeb.FallbackController

  def create(conn, params) do
    case Rocketpay.create_user(params) do
      {:ok, %User{} = user} ->
        conn
        |> put_status(:created)
        |> render("create.json", user: user)

      {:error, result} ->
        conn
        |> put_status(:bad_request)
        |> put_view(RocketpayWeb.ErrorView)
        |> render("400.json", result: result)
    end
  end
end
