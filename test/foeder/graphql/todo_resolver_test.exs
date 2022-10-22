defmodule Foeder.GraphQL.TodoTest do
  use ExUnit.Case, async: true
  alias Foeder.Accounts
  alias Foeder.Ash.Todos

  setup do
    # Explicitly get a connection before each test
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Foeder.Repo)
  end

  describe "todos" do
    setup do
      {:ok, user1_no_perm} = Accounts.register_user(%{
        email: "usr-test-1@gmail.com",
        password: "asdfasdfasdf"
      })
      
      user1 = user1_no_perm |> Foeder.Repo.preload(:user_permissions)


      {:ok, user2_no_perm} = Accounts.register_user(%{
        email: "usr-test-2@gmail.com",
        password: "asdfasdfasdf"
      })
      
      user2 = user2_no_perm |> Foeder.Repo.preload(:user_permissions)
      %{user1: user1, user2: user2}
    end

    test "can fetch todos", %{user1: user1, user2: user2} do
      Todos.todo("test todo 1", user1.id)
      Todos.todo("test todo 2", user2.id)
      
      result = """
      query {
        todos {
          id
          text
          highPriority
          done
        }
      }
      """
      |> Absinthe.run(FoederWeb.Schema, context: %{current_user: user1})
      assert {:ok, %{data: %{"todos" => [%{
        "id" => _,  
        "text" => "test todo 1", 
        "highPriority" => false, 
        "done" => false, 
      }]}}} = result
    end

    test "can create todos", %{user1: user1} do
      result = """
      mutation CreateTodo($text: String){
        createTodo(text: $text) {
          id
          text
          done
          highPriority
        }
      }
      """
      |> Absinthe.run(
        FoederWeb.Schema, 
        context: %{current_user: user1},
        variables: %{ "text" => "test create todo" }
      )
      assert {:ok, %{data: %{"createTodo" => %{
        "id" => todo_id,  
        "text" => "test create todo", 
        "highPriority" => false, 
        "done" => false, 
      }}}} = result
      assert {:ok, [%{id: _}]} = Todos.get_one(todo_id, user1.id)
    end


    test "can update todos", %{user1: user1} do
      {:ok, %{id: todo_id}} = Todos.todo("test todo 1", user1.id)
      result = """
      mutation UpdateTodo($id: ID!, $text: String, $done: Boolean, $highPriority: Boolean){
        updateTodo(id: $id, text: $text, done: $done, highPriority: $highPriority) {
          id
          text
          done
          highPriority
        }
      }
      """
      |> Absinthe.run(
        FoederWeb.Schema, 
        context: %{current_user: user1},
        variables: %{
          "id" => todo_id,
          "text" => "test update todo",
          "done" => true,
          "highPriority" => true
        }
      )
      assert {:ok, %{data: %{"updateTodo" => %{
        "id" => todo_id,  
        "text" => "test update todo", 
        "highPriority" => true, 
        "done" => true, 
      }}}} = result
      assert {:ok, [%{text: "test update todo"}]} = Todos.get_one(todo_id, user1.id)
    end

    test "cant update other users todos", %{user1: user1, user2: user2} do
      {:ok, %{id: todo_id}} = Todos.todo("test todo 1", user2.id)
      result = """
      mutation UpdateTodo($id: ID!, $text: String, $done: Boolean, $highPriority: Boolean){
        updateTodo(id: $id, text: $text, done: $done, highPriority: $highPriority) {
          id
          text
          done
          highPriority
        }
      }
      """
      |> Absinthe.run(
        FoederWeb.Schema, 
        context: %{current_user: user1},
        variables: %{
          "id" => todo_id,
          "text" => "test update todo",
          "done" => true,
          "highPriority" => true
        }
      )
      assert {:ok, %{
        data: %{"updateTodo" => nil},
        errors: [%{message: "Could not find todo to update"}]
      }} = result
      assert {:ok, [%{text: "test todo 1"}]} = Todos.get_one(todo_id, user2.id)
    end
  end
end
