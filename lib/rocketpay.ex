defmodule Rocketpay do
  alias Rocketpay.UseCases.CreateUser
  alias Rocketpay.UseCases.{Deposit, Transfer, Withdraw}

  defdelegate create_user(params), to: CreateUser, as: :call

  defdelegate deposit(params), to: Deposit, as: :call
  defdelegate withdraw(params), to: Withdraw, as: :call
  defdelegate transfer(params), to: Transfer, as: :call
end
