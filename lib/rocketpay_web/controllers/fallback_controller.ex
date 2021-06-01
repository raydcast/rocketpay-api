defmodule RocketpayWeb.FallbackController do
  use RocketpayWeb, :controller

  def call(conn, {:error, result}) do
    conn
    |> put_status(:internal_server_error)
    |> put_view(RocketpayWeb.ErrorView)
    |> render("500.json", result: result)
  end
end
