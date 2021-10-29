defmodule ChatterWeb.UserSocket do
  use Phoenix.Socket

  channel "chat_room:*", ChatterWeb.ChatRoomChannel

  @impl true
  def connect(%{"email" => email}, socket, _connect_info) do
    {:ok, assign(socket, :email, email)}
  end

  def connect(_, _, _), do: :error

  @impl true
  def id(_socket), do: nil
end
