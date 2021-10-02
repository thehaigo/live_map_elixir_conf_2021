defmodule LiveMapViewWeb.MapLive.Show do
  use LiveMapViewWeb, :live_view

  alias LiveMapView.Loggers
  alias LiveMapViewWeb.Presence

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    topic = "map:#{id}"
    Phoenix.PubSub.subscribe(LiveMapView.PubSub, topic)
    setup_presence_data(id)

    devices = Presence.list_presence(topic)

    markers =
      Enum.map(devices, fn d ->
        %{
          device_id: d.current_location.device_id,
          lat: d.current_location.lat,
          lng: d.current_location.lng
        }
      end)

    {
      :noreply,
      socket
      |> assign(:page_title, page_title(socket.assigns.live_action))
      |> assign(:map, Loggers.get_map!(id))
      |> assign(:devices, devices)
      |> push_event("init_map", %{markers: markers})
    }
  end

  @impl true
  def handle_info(%{event: "presence_diff"}, socket = %{assigns: %{map: map}}) do
    {:noreply, assign(socket, devices: Presence.list_presence("map:#{map.id}"))}
  end

  @impl true
  def handle_info({:created_point, point}, socket) do
    create_or_update_marker(point)

    {
      :noreply,
      socket
      |> push_event(
        "created_point",
        %{lat: point.lat, lng: point.lng, device_id: point.device_id}
      )
    }
  end

  defp create_or_update_marker(point) do
    topic = "map:#{point.map_id}"

    if Presence.list(topic) |> Map.has_key?(point.device_id) do
      Presence.update_presence(
        self(),
        topic,
        point.device_id,
        %{current_location: point}
      )
    else
      track(point, topic)
    end
  end

  defp page_title(:show), do: "Show Map"
  defp page_title(:edit), do: "Edit Map"

  defp setup_presence_data(id) do
    if map_size(Presence.list("map:#{id}")) == 0 do
      Loggers.list_points(id)
      |> Enum.group_by(fn p -> p.device_id end)
      |> Enum.map(fn {_device_id, points} -> List.last(points) end)
      |> Enum.each(fn point -> track(point, "map:#{id}") end)
    end
  end

  defp track(point, topic) do
    Presence.track(
      self(),
      topic,
      point.device_id,
      %{id: point.device_id, current_location: point}
    )
  end
end
