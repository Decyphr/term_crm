defmodule TermCrm.Clients.Client do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "clients" do
    field :name, :string
    field :status, Ecto.Enum, values: [:lead, :active, :inactive, :archived]
    field :last_activity, :utc_datetime
    field :email, :string
    field :phone_number, :string
    field :address, :map
    field :deleted_at, :utc_datetime
    field :website, :string

    belongs_to :user, TermCrm.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(client, attrs, user_scope) do
    client
    |> cast(attrs, [
      :name,
      :status,
      :last_activity,
      :email,
      :phone_number,
      :address,
      :deleted_at,
      :website
    ])
    |> validate_required([:name, :status, :email])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+\.[^\s]+$/,
      message: "must be a valid email address"
    )
    |> unique_constraint(:email)
    |> put_change(:user_id, user_scope.user.id)
  end
end
