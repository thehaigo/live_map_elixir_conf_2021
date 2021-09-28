defmodule LiveMapView.Loggers.Map do
  use Ecto.Schema
  import Ecto.Changeset

  schema "maps" do
    field :description, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(map, attrs) do
    map
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
