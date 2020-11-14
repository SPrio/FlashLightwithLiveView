defmodule LiveViewStudioWeb.LightLive do
  use LiveViewStudioWeb, :live_view

  def mount(_params, _session, socket) do
    IO.puts "MOUNT #{inspect(self())}"
    {:ok, assign(socket, :brightness, 10)}
  end

  def handle_event("on", _, socket) do
    IO.puts "ON #{inspect(self())}"
    socket = assign(socket, :brightness, 100)
    {:noreply, socket}
  end

  def handle_event("off", _, socket) do
    IO.puts "OFF #{inspect(self())}"
    socket = assign(socket, :brightness, 0)
    {:noreply, socket}
  end

  def handle_event("down", _, socket) do
    socket = update(socket, :brightness, &max(&1 - 10, 0) )
    {:noreply, socket}
  end

  def handle_event("up", _, socket) do
    socket = update(socket, :brightness, &min(&1 + 10, 100))
    {:noreply, socket}
  end

  def render(assigns) do
    IO.puts "RENDER #{inspect(self())}"
    ~L"""
    <h1>Front Porch Light</h1>
    <div class="meter">
      <span style="width:  <%= @brightness %>%;">
        <%= @brightness %>%
      </span>

    </div>
    <button phx-click="off">
      Off
    </button>

    <button phx-click="on">
      On
    </button>

    <button phx-click="down">
      Down
    </button>

    <button phx-click="up">
      Up
    </button>
    """
  end
end
