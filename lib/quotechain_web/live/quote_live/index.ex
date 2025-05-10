defmodule QuotechainWeb.QuoteLive.Index do
  use QuotechainWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
    <.header>
      Listing Quotes
      <:actions>
        <.link patch={~p"/Quotes/new"}>
          <.button>New Quote</.button>
        </.link>
      </:actions>
    </.header>

    <.table
      id="Quotes"
      rows={@streams.quotes}
      row_click={fn {_id, quote} -> JS.navigate(~p"/Quotes/#{quote}") end}
    >
      <:col :let={{_id, quote}} label="Id">{quote.id}</:col>

      <:col :let={{_id, quote}} label="Item">{quote.item}</:col>

      <:col :let={{_id, quote}} label="Sundry">{quote.sundry}</:col>

      <:action :let={{_id, quote}}>
        <div class="sr-only">
          <.link navigate={~p"/Quotes/#{quote}"}>Show</.link>
        </div>
      </:action>
    </.table>

    <.modal :if={@live_action == :new} id="quote-modal" show on_cancel={JS.patch(~p"/Quotes")}>
      <.live_component
        module={QuotechainWeb.QuoteLive.FormComponent}
        current_user={@current_user}
        id={:new}
        title={@page_title}
        action={@live_action}
        quote={@quote}
        patch={~p"/Quotes"}
      />
    </.modal>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    quotes = Ash.read!(Dovetail.Quote, actor: socket.assigns[:current_user])
    IO.inspect(quotes, label: "ash quote******")
    {:ok,
     socket
     |> stream(:Quotes, Ash.read!(Dovetail.Quote, actor: socket.assigns[:current_user]))
     |> assign_new(:current_user, fn -> nil end)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Quote")
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Quotes")
    |> assign(:quote, nil)
  end

  @impl true
  def handle_info({QuotechainWeb.QuoteLive.FormComponent, {:saved, quote}}, socket) do
    {:noreply, stream_insert(socket, :Quotes, quote)}
  end
end
