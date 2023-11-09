defmodule TextToBinaryWeb.ConversionHTML do
  use TextToBinaryWeb, :html

  embed_templates "conversion_html/*"

  @doc """
  Renders a conversion form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def conversion_form(assigns)
end
