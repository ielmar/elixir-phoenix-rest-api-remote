defmodule BeExercise.Repo.Migrations.CreateSalaries do
  use Ecto.Migration

  def change do
    create table(:salaries) do
      add :amount, :decimal
      add :currency, :string
      add :active, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:salaries, [:user_id])
  end
end
