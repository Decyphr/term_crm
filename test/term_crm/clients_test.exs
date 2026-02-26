defmodule TermCrm.ClientsTest do
  use TermCrm.DataCase

  alias TermCrm.Clients

  describe "clients" do
    alias TermCrm.Clients.Client

    import TermCrm.AccountsFixtures, only: [user_scope_fixture: 0]
    import TermCrm.ClientsFixtures

    @invalid_attrs %{name: nil, status: nil, address: nil, last_activity: nil, email: nil, phone_number: nil, deleted_at: nil, website: nil}

    test "list_clients/1 returns all scoped clients" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      client = client_fixture(scope)
      other_client = client_fixture(other_scope)
      assert Clients.list_clients(scope) == [client]
      assert Clients.list_clients(other_scope) == [other_client]
    end

    test "get_client!/2 returns the client with given id" do
      scope = user_scope_fixture()
      client = client_fixture(scope)
      other_scope = user_scope_fixture()
      assert Clients.get_client!(scope, client.id) == client
      assert_raise Ecto.NoResultsError, fn -> Clients.get_client!(other_scope, client.id) end
    end

    test "create_client/2 with valid data creates a client" do
      valid_attrs = %{name: "some name", status: :lead, address: %{}, last_activity: ~U[2026-02-25 21:47:00Z], email: "some email", phone_number: "some phone_number", deleted_at: ~U[2026-02-25 21:47:00Z], website: "some website"}
      scope = user_scope_fixture()

      assert {:ok, %Client{} = client} = Clients.create_client(scope, valid_attrs)
      assert client.name == "some name"
      assert client.status == :lead
      assert client.address == %{}
      assert client.last_activity == ~U[2026-02-25 21:47:00Z]
      assert client.email == "some email"
      assert client.phone_number == "some phone_number"
      assert client.deleted_at == ~U[2026-02-25 21:47:00Z]
      assert client.website == "some website"
      assert client.user_id == scope.user.id
    end

    test "create_client/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Clients.create_client(scope, @invalid_attrs)
    end

    test "update_client/3 with valid data updates the client" do
      scope = user_scope_fixture()
      client = client_fixture(scope)
      update_attrs = %{name: "some updated name", status: :active, address: %{}, last_activity: ~U[2026-02-26 21:47:00Z], email: "some updated email", phone_number: "some updated phone_number", deleted_at: ~U[2026-02-26 21:47:00Z], website: "some updated website"}

      assert {:ok, %Client{} = client} = Clients.update_client(scope, client, update_attrs)
      assert client.name == "some updated name"
      assert client.status == :active
      assert client.address == %{}
      assert client.last_activity == ~U[2026-02-26 21:47:00Z]
      assert client.email == "some updated email"
      assert client.phone_number == "some updated phone_number"
      assert client.deleted_at == ~U[2026-02-26 21:47:00Z]
      assert client.website == "some updated website"
    end

    test "update_client/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      client = client_fixture(scope)

      assert_raise MatchError, fn ->
        Clients.update_client(other_scope, client, %{})
      end
    end

    test "update_client/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      client = client_fixture(scope)
      assert {:error, %Ecto.Changeset{}} = Clients.update_client(scope, client, @invalid_attrs)
      assert client == Clients.get_client!(scope, client.id)
    end

    test "delete_client/2 deletes the client" do
      scope = user_scope_fixture()
      client = client_fixture(scope)
      assert {:ok, %Client{}} = Clients.delete_client(scope, client)
      assert_raise Ecto.NoResultsError, fn -> Clients.get_client!(scope, client.id) end
    end

    test "delete_client/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      client = client_fixture(scope)
      assert_raise MatchError, fn -> Clients.delete_client(other_scope, client) end
    end

    test "change_client/2 returns a client changeset" do
      scope = user_scope_fixture()
      client = client_fixture(scope)
      assert %Ecto.Changeset{} = Clients.change_client(scope, client)
    end
  end
end
