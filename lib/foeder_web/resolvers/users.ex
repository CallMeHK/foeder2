defmodule FoederWeb.Resolvers.Users do
  alias Foeder.Repo
  alias Foeder.Accounts.{User, UserPermissions}
  import FoederWeb.Resolvers.Authz
  import Ecto.Query
  use Ecto.Schema

  defp format_user_for_response(user) do
    user
    |> Map.delete(:password)
    |> Map.delete(:hashed_password)
    |> Map.merge(%{ 
      inserted_at: NaiveDateTime.to_string(user.inserted_at), 
      updated_at: NaiveDateTime.to_string(user.updated_at) 
    })
  end

  defp format_permissions_for_response(permissions) do 
      add_if_permitted = fn list, permission -> 
        if Map.get(permissions, permission) do
          list ++ [Atom.to_string(permission)]
        else
          list
        end
      end

      permitted_actions = []
                          |> add_if_permitted.(:is_super_admin)
                          |> add_if_permitted.(:can_admin_users)
      %{
        id: permissions.id,
        permitted_actions: permitted_actions,
        updated_at: permissions.updated_at
      }
  end

  def list_users(_parent, _args, resolution) do
    permission resolution, :can_admin_users do
      users = User
        |> Repo.all()
        |> Enum.map(&format_user_for_response/1)
      {:ok, users}
    end
  end

  def list_user_permissions(parent_user, _args, resolution) do
    permission resolution, :can_admin_users do
      permissions = UserPermissions
        |> where(user_id: ^parent_user.id)
        |> Repo.one()


      {:ok, format_permissions_for_response(permissions)}
    end
  end

  def update_user_permissions(_parent, args, resolution) do
    permission resolution, :can_admin_users do
      {:ok, user_permission} = UserPermissions
        |> Repo.get_by(user_id: Map.get(args, :user_id))
        |> Ecto.Changeset.change(Map.delete(args, :user_id))
        |> Repo.update()
        |> IO.inspect

      {:ok, format_permissions_for_response(user_permission)}
    end
  end

  def update_user_info(_parent, %{user_id: user_id} = args, resolution) do
    permission resolution, :can_admin_users do
      {user_id, _} = user_id |> Integer.parse() 

      confirmed_at = if Map.get(args, :confirmed_at) == nil, do: nil, else: NaiveDateTime.local_now()
      changes = args
                |> Map.delete(:user_id)
                |> Map.put(:confirmed_at, confirmed_at)

      {:ok, user} = %User{id: user_id}
        |> Ecto.Changeset.change(changes)
        |> Repo.update()
      
      password = Map.get(args, :password)
      if(password != nil) do
        u = User |> Repo.get_by(id: user.id)
        IO.inspect(u)
        {result, _} = Foeder.Accounts.reset_user_password(u, %{password: password, password_confirmation: password})
                      |> IO.inspect
        if result == :ok, do: {:ok, user}, else: {:error, "Failed to update password"}
      else
        {:ok, user}
      end
    end
  end

  def update_user_info(_parent, _args, _resolution) do
    {:error, "no user id"}
  end
end
