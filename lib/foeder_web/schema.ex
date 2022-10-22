defmodule FoederWeb.Schema do
  use Absinthe.Schema
  import_types FoederWeb.Schema.ContentTypes

  alias FoederWeb.Resolvers

  query do
    @desc "Get all users"
    field :users, list_of(:user) do
      resolve &Resolvers.Users.list_users/3
    end
    field :user_permissions, list_of(:string) do
      resolve &Resolvers.Authz.list_user_permissions/3
    end
    @desc "Shows current users permissions"
    field :permissions, :permissions do
      resolve &Resolvers.Users.list_user_permissions/3
    end
    @desc "Gets all todos"
    field :todos, list_of(:todo) do
      resolve &Resolvers.Todos.get_user_todos/3
    end
  end

  mutation do
    @desc "Update user permissions"
    field :update_user_permissions, :permissions do
      arg :user_id, non_null(:id)
      arg :is_super_admin, :boolean
      arg :can_admin_users, :boolean

      resolve &Resolvers.Users.update_user_permissions/3
    end

    @desc "Update user info"
    field :update_user_info, :user do
      arg :user_id, :id
      arg :email, :string
      arg :confirmed_at, :string
      arg :password, :string

      resolve &Resolvers.Users.update_user_info/3
    end

    @desc "Update todo"
    field :update_todo, :todo do
      arg :id, non_null(:id)
      arg :text, :string
      arg :done, :boolean
      arg :high_priority, :boolean

      resolve &Resolvers.Todos.update_todo/3
    end
  end

end
