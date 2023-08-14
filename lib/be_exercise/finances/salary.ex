defmodule BeExercise.Finances.Salary do
  use Ecto.Schema
  import Ecto.Changeset

  schema "salaries" do
    field :active, :boolean, default: false
    field :currency, :string
    field :amount, :decimal
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(salary, attrs) do
    salary
    |> cast(attrs, [:amount, :currency, :active])
    |> validate_required([:amount, :currency, :active])
  end
end
