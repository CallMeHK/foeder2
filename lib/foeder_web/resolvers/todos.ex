defmodule FoederWeb.Resolvers.Todos do
  alias Foeder.Ash.Todos
  import FoederWeb.Resolvers.Authz

  def get_user_todos(_parent, _args, resolution) do
    logged_in resolution do
      Todos.user_todos get_user(resolution).id
    end
  end

  def create_todo(_parent, %{text: text}, resolution) do
    logged_in resolution do
      Todos.todo(text, get_user(resolution).id)
    end
  end

  def update_todo(_parent, %{id: todo_id} = args, resolution) do
    logged_in resolution do
      case Todos.get_one(todo_id, get_user(resolution).id)  do
        {:ok, [todo]} -> todo |> Todos.update(args)
        _ -> {:error, "Could not find todo to update"}
      end
    end
  end
end
