# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Foeder.Repo.insert!(%Foeder.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Foeder.Accounts
alias Foeder.Ash.Todos

Accounts.register_user(%{
  email: "hkrazy888@gmail.com",
  password: "asdfasdfasdf"
}, [ :is_super_admin, :can_admin_users ])

Accounts.register_user(%{
  email: "usr1@gmail.com",
  password: "asdfasdfasdf"
})

Accounts.register_user(%{
  email: "usr2@gmail.com",
  password: "asdfasdfasdf"
})

Todos.todo("wash clothes", 1)
Todos.todo("eat dinner", 1)
Todos.todo("clean dogs", 1)
Todos.todo("workout", 1)
Todos.todo("hang out", 1)


Todos.todo("workout", 2)
Todos.todo("hang out", 2)

Todos.todo("see movie", 3)
Todos.todo("touch bugs", 3)
Todos.todo("yeet", 3)
