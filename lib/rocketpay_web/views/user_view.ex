defmodule RocketpayWeb.UserView do
  alias Rocketpay.Schemas.User
  alias Rocketpay.Schemas.Account

  def render("create.json", %{
        user: %User{
          account: %Account{
            id: account_id,
            balance: balance
          },
          id: id,
          name: name,
          nickname: nickname
        }
      }) do
    %{
      result: "success",
      user: %{
        id: id,
        name: name,
        nickname: nickname,
        account: %{
          id: account_id,
          balance: balance
        }
      }
    }
  end
end
