defmodule BeExercise.Finances.Salary do
  use Ecto.Schema
  import Ecto.Changeset
  alias BeExercise.Accounts.User

  schema "salaries" do
    field :active, :boolean, default: false
    field :currency, :string
    field :amount, :decimal
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(salary, attrs) do
    salary
    |> cast(attrs, [:amount, :currency, :active])
    |> validate_required([:amount, :currency, :active])
  end
end
