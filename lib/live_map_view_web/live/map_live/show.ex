defmodule LiveMapViewWeb.MapLive.Show do
  use LiveMapViewWeb, :live_view

  alias LiveMapView.Loggers

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    Phoenix.PubSub.subscribe(LiveMapView.PubSub, "map:#{id}")
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:map, Loggers.get_map!(id))}
  end

  def handle_info({:created_point, point}, socket) do
    {
      :noreply,
      socket
      |> push_event(
        "created_point",
        %{lat: point.lat, lng: point.lng, device_id: point.device_id}
      )
    }
  end

  defp page_title(:show), do: "Show Map"
  defp page_title(:edit), do: "Edit Map"
end
