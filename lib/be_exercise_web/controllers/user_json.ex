defmodule BeExerciseWeb.UserJSON do

  @doc """
  Renders a list of users.
  """
  def index(%{users: users}) do
    %{data: for(user <- users, do: data(user))}
  end

  @doc """
  Renders a single user.
  """
  def show(%{user: user}) do
    %{data: data(user)}
  end

  defp data(%{user: user, active_salary: active_salary}) do
    %{
      id: user.id,
      name: user.name,
      salary: active_salary.amount,
      currency: active_salary.currency
    }
  end
end
