defmodule Foeder.Repo do
  use Ecto.Repo,
    otp_app: :foeder,
    adapter: Ecto.Adapters.Postgres
end
