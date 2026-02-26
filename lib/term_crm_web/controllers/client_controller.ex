defmodule TermCrmWeb.ClientController do
  use TermCrmWeb, :controller

  alias TermCrm.Clients
  alias TermCrm.Clients.Client

  def index(conn, _params) do
    clients = Clients.list_clients(conn.assigns.current_scope)
    render(conn, :index, clients: clients)
  end

  def new(conn, _params) do
    changeset =
      Clients.change_client(conn.assigns.current_scope, %Client{
        user_id: conn.assigns.current_scope.user.id
      })

    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"client" => client_params}) do
    case Clients.create_client(conn.assigns.current_scope, client_params) do
      {:ok, client} ->
        conn
        |> put_flash(:info, "Client created successfully.")
        |> redirect(to: ~p"/clients/#{client}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    client = Clients.get_client!(conn.assigns.current_scope, id)
    render(conn, :show, client: client)
  end

  def edit(conn, %{"id" => id}) do
    client = Clients.get_client!(conn.assigns.current_scope, id)
    changeset = Clients.change_client(conn.assigns.current_scope, client)
    render(conn, :edit, client: client, changeset: changeset)
  end

  def update(conn, %{"id" => id, "client" => client_params}) do
    client = Clients.get_client!(conn.assigns.current_scope, id)

    case Clients.update_client(conn.assigns.current_scope, client, client_params) do
      {:ok, client} ->
        conn
        |> put_flash(:info, "Client updated successfully.")
        |> redirect(to: ~p"/clients/#{client}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, client: client, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    client = Clients.get_client!(conn.assigns.current_scope, id)
    {:ok, _client} = Clients.delete_client(conn.assigns.current_scope, client)

    conn
    |> put_flash(:info, "Client deleted successfully.")
    |> redirect(to: ~p"/clients")
  end
end
