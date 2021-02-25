defmodule RocketpayWeb.UsersController do
  use RocketpayWeb, :controller

  action_fallback RocketpayWeb.FallbackController

  def create(conn, params) do
    # caso não dê match, devolve o erro para quem chamou a function
    with {:ok, %Rocketpay.User{} = user} <- Rocketpay.create_user(params) do
      conn
      |> put_status(:created)
      |> render(:create, user: user)
    end
  end
end
