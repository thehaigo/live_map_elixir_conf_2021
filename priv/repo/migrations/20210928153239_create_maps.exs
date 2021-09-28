defmodule LiveMapView.Repo.Migrations.CreateMaps do
  use Ecto.Migration

  def change do
    create table(:maps) do
      add :name, :string
      add :description, :string

      timestamps()
    end
  end
end
