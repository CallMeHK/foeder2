defmodule FoederWeb.Resolvers.Authz do

  @user_permissions [:can_admin_users, :is_super_admin]

  def get_in?(obj, keys) do
    obj
    |> get_in(Enum.map(keys, &(Access.key(&1))))
  end

  def get_user(resolution) do 
    resolution 
    |> get_in?([ 
      :context, 
      :current_user
      ])
  end

  def get_user_permissions(resolution) do 
    resolution 
      |> get_in?([ 
        :context, 
        :current_user,
        :user_permissions
        ])
        |> Enum.reduce([], fn perm, acc -> 
          IO.inspect perm
          acc
         # if perm do
         #   IO.inspect
         # else
         # end
        end)
  end

  defmacro logged_in(resolution, do: expr) do
    quote do
      current_user = unquote(resolution) 
                            |> get_in?([ 
                              :context, 
                              :current_user, 
                            ])
      IO.inspect current_user
      if(current_user) do
        unquote(expr)
      else
        {:error, "User must be authenticated"}
      end
    end
  end

  defmacro permission(resolution, permission_set, do: expr) do
    quote do
      required_permission = unquote(resolution) 
                            |> get_in?([ 
                              :context, 
                              :current_user, 
                              :user_permissions, 
                              unquote(permission_set) 
                            ])
      if(required_permission) do
        unquote(expr)
      else
        {:error, "Missing authorization: " <> Atom.to_string(unquote(permission_set))}
      end
    end
  end

  def list_user_permissions(_parent, _args, resolution) do
    logged_in resolution do
      {:ok, @user_permissions}
    end
  end
end
