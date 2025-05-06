defmodule QuotechainWeb.QuoteLive.FormComponent do
  use QuotechainWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage quote records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="quote-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:quote_number]} type="text" label="Quote number" /><.input
          field={@form[:quote_obj]}
          type="number"
          label="Quote obj"
          step="any"
        /><.input field={@form[:quote_date]} type="date" label="Quote date" /><.input
          field={@form[:account_reference]}
          type="text"
          label="Account reference"
        /><.input field={@form[:shipper_reference]} type="text" label="Shipper reference" /><.input
          field={@form[:service_type]}
          type="text"
          label="Service type"
        /><.input field={@form[:rate_type]} type="text" label="Rate type" /><.input
          field={@form[:consignor_site]}
          type="text"
          label="Consignor site"
        /><.input field={@form[:consignor_name]} type="text" label="Consignor name" /><.input
          field={@form[:consignor_street]}
          type="text"
          label="Consignor street"
        /><.input field={@form[:consignor_suburb]} type="text" label="Consignor suburb" /><.input
          field={@form[:consignor_city]}
          type="text"
          label="Consignor city"
        /><.input field={@form[:consignor_postal_code]} type="text" label="Consignor postal code" /><.input
          field={@form[:consignee_site]}
          type="text"
          label="Consignee site"
        /><.input field={@form[:consignee_name]} type="text" label="Consignee name" /><.input
          field={@form[:consignee_street]}
          type="text"
          label="Consignee street"
        /><.input field={@form[:consignee_suburb]} type="text" label="Consignee suburb" /><.input
          field={@form[:consignee_city]}
          type="text"
          label="Consignee city"
        /><.input field={@form[:consignee_postal_code]} type="text" label="Consignee postal code" />

        <:actions>
          <.button phx-disable-with="Saving...">Save Quote</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_form()}
  end

  @impl true
  def handle_event("validate", %{"quote" => quote_params}, socket) do
    {:noreply, assign(socket, form: AshPhoenix.Form.validate(socket.assigns.form, quote_params))}
  end

  def handle_event("save", %{"quote" => quote_params}, socket) do
    case AshPhoenix.Form.submit(socket.assigns.form, params: quote_params) do
      {:ok, quote} ->
        notify_parent({:saved, quote})

        socket =
          socket
          |> put_flash(:info, "Quote created successfully")
          |> push_patch(to: socket.assigns.patch)

        {:noreply, socket}

      {:error, form} ->
        {:noreply, assign(socket, form: form)}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})

  defp assign_form(%{assigns: %{quote: quote}} = socket) do
    form =
      AshPhoenix.Form.for_create(quote, :request, as: "quote", actor: socket.assigns.current_user)

    assign(socket, form: to_form(form))
  end
end
