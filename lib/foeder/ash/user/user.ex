defmodule Foeder.Ash.User do
  # This turns this module into a resource
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "users"
    repo Foeder.Ash.Repo
  end

#  code_interface do
#    define_for Foeder.Ash.Registry
#
#    define :get, args: [:id]
#  end

  actions do
    # Add a set of simple actions. You'll customize these later.
    defaults [:create, :read, :update, :destroy]
  end

  # Attributes are the simple pieces of data that exist on your resource
  attributes do
    # Add an autogenerated UUID primary key called `:id`.
    uuid_primary_key :id

    attribute :email, :string do
      allow_nil? false
    end
  end

  relationships do
    # belongs_to means that the destination attribute is unique, meaning only one related record could exist.
    # We assume that the destination attribute is `representative_id` based
    # on the name of this relationship and that the source attribute is `representative_id`.
    # We create `representative_id` automatically.
    has_many :todo, Foeder.Ash.Todos
  end
end

