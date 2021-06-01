defmodule RocketpayWeb.AccountView do
  alias Rocketpay.Schemas.Account

  def render("transfer.json", %{
        account: %Account{
          id: account_id,
          balance: balance
        }
      }) do
    %{
      result: "success",
      account: %{
        id: account_id,
        balance: balance
      }
    }
  end

  def render("update.json", %{
        account: %Account{
          id: account_id,
          balance: balance
        }
      }) do
    %{
      result: "success",
      account: %{
        id: account_id,
        balance: balance
      }
    }
  end
end
