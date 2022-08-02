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
