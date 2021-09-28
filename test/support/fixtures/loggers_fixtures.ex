defmodule LiveMapView.LoggersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LiveMapView.Loggers` context.
  """

  @doc """
  Generate a map.
  """
  def map_fixture(attrs \\ %{}) do
    {:ok, map} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name"
      })
      |> LiveMapView.Loggers.create_map()

    map
  end
end
