defmodule TermCrm.Repo do
  use Ecto.Repo,
    otp_app: :term_crm,
    adapter: Ecto.Adapters.Postgres
end
