defmodule TermCrm.ClientsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TermCrm.Clients` context.
  """

  @doc """
  Generate a client.
  """
  def client_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        address: %{},
        deleted_at: ~U[2026-02-25 21:47:00Z],
        email: "some email",
        last_activity: ~U[2026-02-25 21:47:00Z],
        name: "some name",
        phone_number: "some phone_number",
        status: :lead,
        website: "some website"
      })

    {:ok, client} = TermCrm.Clients.create_client(scope, attrs)
    client
  end
end
