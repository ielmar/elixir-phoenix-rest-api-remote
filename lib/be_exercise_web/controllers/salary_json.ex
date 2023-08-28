defmodule BeExerciseWeb.SalaryJSON do
  alias BeExercise.Finances.Salary

  @doc """
  Renders a list of salaries.
  """
  def index(%{salaries: salaries}) do
    %{data: for(salary <- salaries, do: data(salary))}
  end

  @doc """
  Renders a single salary.
  """
  def show(%{salary: salary}) do
    %{data: data(salary)}
  end

  defp data(%Salary{} = salary) do
    %{
      id: salary.id,
      user_id: salary.user_id,
      amount: salary.amount,
      currency: salary.currency,
      active: salary.active
    }
  end
end
