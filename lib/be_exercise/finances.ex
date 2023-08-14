defmodule BeExercise.Finances do
  @moduledoc """
  The Finances context.
  """

  import Ecto.Query, warn: false
  alias BeExercise.Repo

  alias BeExercise.Finances.Salary

  @doc """
  Returns the list of salaries.

  ## Examples

      iex> list_salaries()
      [%Salary{}, ...]

  """
  def list_salaries do
    Repo.all(Salary)
  end

  @doc """
  Gets a single salary.

  Raises `Ecto.NoResultsError` if the Salary does not exist.

  ## Examples

      iex> get_salary!(123)
      %Salary{}

      iex> get_salary!(456)
      ** (Ecto.NoResultsError)

  """
  def get_salary!(id), do: Repo.get!(Salary, id)

  @doc """
  Creates a salary.

  ## Examples

      iex> create_salary(%{field: value})
      {:ok, %Salary{}}

      iex> create_salary(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_salary(attrs \\ %{}) do
    %Salary{}
    |> Salary.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a salary.

  ## Examples

      iex> update_salary(salary, %{field: new_value})
      {:ok, %Salary{}}

      iex> update_salary(salary, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_salary(%Salary{} = salary, attrs) do
    salary
    |> Salary.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a salary.

  ## Examples

      iex> delete_salary(salary)
      {:ok, %Salary{}}

      iex> delete_salary(salary)
      {:error, %Ecto.Changeset{}}

  """
  def delete_salary(%Salary{} = salary) do
    Repo.delete(salary)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking salary changes.

  ## Examples

      iex> change_salary(salary)
      %Ecto.Changeset{data: %Salary{}}

  """
  def change_salary(%Salary{} = salary, attrs \\ %{}) do
    Salary.changeset(salary, attrs)
  end
end
