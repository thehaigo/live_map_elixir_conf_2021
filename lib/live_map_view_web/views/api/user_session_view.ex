defmodule LiveMapViewWeb.Api.UserSessionView do
  use LiveMapViewWeb, :view

  def render("token.json", %{token: token}) do
    %{token: token}
  end
end
