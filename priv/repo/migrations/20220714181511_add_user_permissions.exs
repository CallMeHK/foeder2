defmodule Foeder.Repo.Migrations.AddUserPermissions do
  use Ecto.Migration

  def change do
    create table(:user_permissions) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :is_super_admin, :boolean, null: false
      add :can_admin_users, :boolean, null: false
      timestamps()
    end
  end
end
