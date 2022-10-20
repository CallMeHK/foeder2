defmodule Foeder.Ash.Entries do
  use Ash.Registry,
    extensions: [
      # This extension adds helpful compile time validations
      Ash.Registry.ResourceValidations
    ]

  entries do
    entry Foeder.Ash.User
    entry Foeder.Ash.Todos
  end
end


defmodule Foeder.Ash.Registry do
  use Ash.Api

  resources do
    # This defines the set of resources that can be used with this API
    registry Foeder.Ash.Entries
  end
end

