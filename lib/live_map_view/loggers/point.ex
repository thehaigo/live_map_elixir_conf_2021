defmodule LiveMapView.Loggers.Point do
  use Ecto.Schema
  import Ecto.Changeset

  schema "points" do
    field :device_id, :string
    field :lat, :float
    field :lng, :float
    field :map_id, :integer

    timestamps()
  end

  @doc false
  def changeset(point, attrs) do
    point
    |> cast(attrs, [:lat, :lng, :device_id, :map_id])
    |> validate_required([:lat, :lng, :device_id, :map_id])
  end
end
