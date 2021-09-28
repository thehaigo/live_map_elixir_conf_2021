defmodule LiveMapViewWeb.MapController do
  use LiveMapViewWeb, :controller

  alias LiveMapView.Loggers
  alias LiveMapView.Loggers.Map

  action_fallback LiveMapViewWeb.FallbackController

  def index(conn, _params) do
    maps = Loggers.list_maps()
    render(conn, "index.json", maps: maps)
  end

  def create(conn, %{"map" => map_params}) do
    with {:ok, %Map{} = map} <- Loggers.create_map(map_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.map_path(conn, :show, map))
      |> render("show.json", map: map)
    end
  end

  def show(conn, %{"id" => id}) do
    map = Loggers.get_map!(id)
    render(conn, "show.json", map: map)
  end

  def update(conn, %{"id" => id, "map" => map_params}) do
    map = Loggers.get_map!(id)

    with {:ok, %Map{} = map} <- Loggers.update_map(map, map_params) do
      render(conn, "show.json", map: map)
    end
  end

  def delete(conn, %{"id" => id}) do
    map = Loggers.get_map!(id)

    with {:ok, %Map{}} <- Loggers.delete_map(map) do
      send_resp(conn, :no_content, "")
    end
  end
end
