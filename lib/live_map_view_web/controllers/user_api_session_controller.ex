defmodule LiveMapViewWeb.UserApiSessionController do
  use LiveMapViewWeb, :controller

  alias LiveMapView.Accounts

  def create(conn, %{"email" => email, "password" => password}) do
    if user = Accounts.get_user_by_email_and_password(email, password) do
      render(
        conn,
        "token.json",
        token: Accounts.generate_user_session_token(user) |> Base.encode64()
      )
    else
      conn
      |> put_status(:unauthorized)
      |> put_view(LiveMapWeb.ErrorView)
      |> render(:"401")
    end
  end
end
