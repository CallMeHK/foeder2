defmodule FoederWeb.Schema.ContentTypes do
  use Absinthe.Schema.Notation
  alias FoederWeb.Resolvers
  import_types Absinthe.Type.Custom

  object :user do
    field :id, :id
    field :email, :string
    field :confirmed_at, :string
    field :inserted_at, :string
    field :updated_at, :string
    field :permissions, :permissions do
      resolve &Resolvers.Users.list_user_permissions/3
    end
  end

  object :permissions do
    field :id, :id
    field :permitted_actions, list_of(:string)
    field :updated_at, :naive_datetime
  end
end
