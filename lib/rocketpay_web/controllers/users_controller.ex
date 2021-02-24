defmodule RocketpayWeb.UsersController do
  use RocketpayWeb, :controller

  def create(conn, params) do
    params
    |> Rocketpay.create_user()
    |> handle_response(conn)
  end

  def handle_response({:ok, %Rocketpay.User{} = struct}, conn) do
    conn
    |> put_status(:created)
    |> render(:create, user: struct)
  end

  def handle_response({:error, changeset}, conn) do
    conn
    |> put_status(:bad_request)
    |> put_view(RocketpayWeb.ErrorView)
    |> render(:"400", result: changeset)
  end
end
