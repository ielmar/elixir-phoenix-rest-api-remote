# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     BeExercise.Repo.insert!(%BeExercise.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias BeExercise.{Repo, Accounts.User, Finances.Salary}
# alias Ecto.Multi

for [User, Salary] <- [User, Salary] do
  Repo.delete_all(User)
  Repo.delete_all(Salary)
end

feed_count = 200
currencies_data = ["USD", "EUR", "JPY", "GBP", "CAD", "AUD", "CHF", "CNY", "SEK", "NZD"]

names = File.read!("priv/data/names.txt")
|> String.split("\n")

Enum.map(0..feed_count, fn _ ->
  user = User.changeset(%User{}, %{name: Enum.random(names)})
  |> Repo.insert!()

  Ecto.build_assoc(user, :salaries, %{amount: Enum.random(1000..10000), currency: Enum.random(currencies_data), active: false})
  |> Repo.insert!()

  Ecto.build_assoc(user, :salaries, %{amount: Enum.random(1000..10000), currency: Enum.random(currencies_data), active: Enum.random([true, false])})
  |> Repo.insert!()

end)

IO.puts("Seeding complete!")
