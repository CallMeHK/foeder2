defmodule Foeder.Accounts.UserPermissions do
  use Ecto.Schema
  alias Foeder.Repo
  alias Foeder.Accounts.UserPermissions
  # import Ecto.Changeset

  schema "user_permissions" do
    field :is_super_admin, :boolean
    field :can_admin_users, :boolean
    belongs_to :user, Foeder.Accounts.User

    timestamps()
  end

  def create(user_id, permissions \\ []) do
      has_permission = &Enum.member?(permissions, &1)
      %UserPermissions{
        user_id: user_id,
        is_super_admin: has_permission.(:is_super_admin),
        can_admin_users: has_permission.(:can_admin_users)
      } |> Repo.insert()
  end

  def update(id, permissions \\ %{}) do
    %UserPermissions{id: id}
    |> Ecto.Changeset.change(permissions)
    |> Repo.update()
  end
end
