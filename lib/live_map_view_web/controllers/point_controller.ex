defmodule LiveMapViewWeb.PointController do
  use LiveMapViewWeb, :controller

  alias LiveMapView.Loggers
  alias LiveMapView.Loggers.Point

  action_fallback LiveMapViewWeb.FallbackController

  def create(conn, point_params) do
    with {:ok, %Point{}} <- Loggers.create_point(point_params) do
      send_resp(conn, 200, "ok")
    end
  end
end
