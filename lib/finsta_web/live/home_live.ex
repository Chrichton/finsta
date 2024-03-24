defmodule FinstaWeb.HomeLive do
  use FinstaWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1 class="text-2xl">Finsta</h1>
    """
  end
end
