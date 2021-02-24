defmodule RocketpayWeb.UsersView do
  def render("create.json", %{user: %Rocketpay.User{} = user}) do
    %{
      data:
        user
        |> Map.delete(:__meta__)
        |> Map.delete(:__struct__)
        |> Map.delete(:password)
    }.data
  end
end
