defmodule LiveMapViewWeb.MapView do
  use LiveMapViewWeb, :view
  alias LiveMapViewWeb.MapView

  def render("index.json", %{maps: maps}) do
    %{data: render_many(maps, MapView, "map.json")}
  end

  def render("show.json", %{map: map}) do
    %{data: render_one(map, MapView, "map.json")}
  end

  def render("map.json", %{map: map}) do
    %{
      id: map.id,
      name: map.name,
      description: map.description
    }
  end
end
