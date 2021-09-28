defmodule LiveMapView.Repo do
  use Ecto.Repo,
    otp_app: :live_map_view,
    adapter: Ecto.Adapters.Postgres
end
