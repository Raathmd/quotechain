defmodule QuotechainWeb.QuoteLive.Show do
  use QuotechainWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
    <.header>
      Quote {@quote.id}
      <:subtitle>This is a quote record from your database.</:subtitle>
    </.header>

    <.list>
      <:item title="Id">{@quote.id}</:item>

      <:item title="Item">{@quote.item}</:item>

      <:item title="Sundry">{@quote.sundry}</:item>
    </.list>

    <.back navigate={~p"/Quotes"}>Back to Quotes</.back>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:quote, Ash.get!(Dovetail.Quote, id, actor: socket.assigns.current_user))}
  end

  defp page_title(:show), do: "Show Quote"
  defp page_title(:edit), do: "Edit Quote"
end
