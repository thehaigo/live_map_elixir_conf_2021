defmodule LiveMapView.Repo.Migrations.CreatePoints do
  use Ecto.Migration

  def change do
    create table(:points) do
      add :lat, :float
      add :lng, :float
      add :device_id, :string
      add :map_id, :integer

      timestamps()
    end
  end
end
