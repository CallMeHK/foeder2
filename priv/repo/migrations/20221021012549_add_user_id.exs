defmodule Foeder.Ash.Repo.Migrations.AddUserId do
  @moduledoc """
  Updates resources based on their most recent snapshots.

  This file was autogenerated with `mix ash_postgres.generate_migrations`
  """

  use Ecto.Migration

  def up do
    alter table(:todo) do
      add :created_at, :utc_datetime_usec, null: false, default: fragment("now()")
      add :updated_at, :utc_datetime_usec, null: false, default: fragment("now()")
    end
  end

  def down do
    alter table(:todo) do
      remove :updated_at
      remove :created_at
    end
  end
end