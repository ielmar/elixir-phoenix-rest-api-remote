defmodule BeExercise.Repo.Migrations.AddTimestamps do
  use Ecto.Migration

  def change do
    alter table(:users) do
      timestamps null: true
    end

    execute """
    UPDATE users
    SET updated_at=NOW(), inserted_at=NOW()
    """

    alter table(:users) do
      modify :inserted_at, :utc_datetime, null: false
      modify :updated_at, :utc_datetime, null: false
    end
  end
end
