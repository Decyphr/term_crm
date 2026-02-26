defmodule TermCrmWeb.ClientHTML do
  use TermCrmWeb, :html

  embed_templates "client_html/*"

  @doc """
  Renders a client form.

  The form is defined in the template at
  client_html/client_form.html.heex
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true
  attr :return_to, :string, default: nil

  def client_form(assigns)
end
