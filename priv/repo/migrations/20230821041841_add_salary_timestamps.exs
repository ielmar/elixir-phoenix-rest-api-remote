defmodule BeExercise.Repo.Migrations.AddSalaryTimestamps do
  use Ecto.Migration

  def change do
    alter table(:salaries) do
      timestamps null: true
    end

    execute """
    UPDATE salaries
    SET updated_at=NOW(), inserted_at=NOW()
    """

    alter table(:salaries) do
      modify :inserted_at, :utc_datetime, null: false
      modify :updated_at, :utc_datetime, null: false
    end
  end
end
