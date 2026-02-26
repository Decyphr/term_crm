defmodule TermCrm.Repo.Migrations.CreateClients do
  use Ecto.Migration

  def change do
    create table(:clients, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :status, :string, null: false
      add :email, :string, null: false
      add :last_activity, :utc_datetime
      add :phone_number, :string
      add :address, :map
      add :deleted_at, :utc_datetime
      add :website, :string
      add :user_id, references(:users, type: :binary_id, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:clients, [:user_id])
    create unique_index(:clients, [:email])
  end
end
