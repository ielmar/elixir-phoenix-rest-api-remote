defmodule BeExerciseWeb.UserJSON do

  @doc """
  Renders a list of users.
  """
  def index(%{users_with_salaries: users_with_salaries}) do
    %{data: for(user <- users_with_salaries, do: data(user))}
  end

  @doc """
  Renders a single user.
  """
  def show(%{user: user}) do
    %{data: data(user)}
  end

  defp data(user) do
    %{user: user_data} = user
    %{
      id: user_data.id,
      name: user_data.name,
      salary: user.salary,
      currency: user.currency
    }
  end

  @doc """
  Renders :ok after emails are sent
  """
  def emails_sent(_assigns) do
    :ok
  end
end
