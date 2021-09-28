defmodule LiveMapViewWeb.PageController do
  use LiveMapViewWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
