defmodule FoederWeb.TodosController do
  use FoederWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
