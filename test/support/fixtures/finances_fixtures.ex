defmodule BeExercise.FinancesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BeExercise.Finances` context.
  """

  @doc """
  Generate a salary.
  """
  def salary_fixture(attrs \\ %{}) do
    {:ok, salary} =
      attrs
      |> Enum.into(%{
        active: true,
        currency: "some currency",
        amount: "120.5"
      })
      |> BeExercise.Finances.create_salary()

    salary
  end
end
