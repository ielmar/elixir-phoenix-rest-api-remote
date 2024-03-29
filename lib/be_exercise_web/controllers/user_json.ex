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

  defp data(%{user: user, salary: salary, currency: currency}) do
    %{
      id: user.id,
      name: user.name,
      salary: salary,
      currency: currency
    }
  end

  defp data(%{id: id, name: name, salaries: salaries}) do
    %{
      id: id,
      name: name,
      salaries:
        Enum.map(salaries, fn salary ->
          %{
            id: salary.id,
            active: salary.active,
            salary: salary.amount,
            currency: salary.currency
          }
        end)
    }
  end

  @doc """
  Renders :ok after user is created
  """
  def show_ok(_assigns) do
    :ok
  end

  @doc """
  Renders :ok after emails are sent
  """
  def emails_sent(%{emails_sent: emails_sent}) do
    %{
      emails_sent: emails_sent
    }
  end
end
