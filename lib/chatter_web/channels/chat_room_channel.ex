defmodule ChatterWeb.ChatRoomChannel do
  use ChatterWeb, :channel

  @impl true
  def join("chat_room" <> _room_name, _msg, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_in("new_message", payload, socket) do
    broadcast(socket, "new_message", payload)
    {:noreply, socket}
  end
end
