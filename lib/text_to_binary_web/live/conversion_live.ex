defmodule TextToBinaryWeb.ConversionLive do
  use TextToBinaryWeb, :live_view

    # Initialize the assigns when the LiveView is mounted
    def mount(_params, _session, socket) do
      {:ok, assign(socket, text: "", binary: "")} # You can set initial values here
    end

    @spec render(any) :: Phoenix.LiveView.Rendered.t()
    def render(assigns) do
      ~L"""
      <form phx-submit="convert">
      <b>Type your text</b><br>
        <input type="text" name="text" phx-keyup="convert" value="<%= @text %>" />
        <div><b>Binary</b><br><code><%= @binary %></code></div>
        <button type="button" phx-click="save_conversion">Save Conversion</button>
      </form>
      """
    end

  @spec mount(any, any) :: {:ok, any}
  def mount(_session, socket) do
    IO.inspect(socket, label: "socket in mount")
    {:ok, assign(socket, text: "", binary: "")}
  end

  def handle_event("convert", %{"value" => text}, socket) do
    binary = TextToBinary.Conversions.Conversion.text_to_utf8_binary(text)
    {:noreply, assign(socket, text: text, binary: binary)}
  end

  def handle_event("save_conversion", _params, socket) do
    conversion_params = %{
      input_text: socket.assigns.text,
      output_binary: socket.assigns.binary
    }
    TextToBinary.Conversions.create_conversion(conversion_params)
    {:noreply, push_redirect(socket, to: "/conversions")}
    # {:noreply, socket}
  end

end
