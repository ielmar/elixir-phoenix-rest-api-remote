defmodule BeExerciseWeb.UserController do
  use BeExerciseWeb, :controller

  alias BeExercise.{Repo, Accounts, Accounts.User}

  require Logger

  action_fallback BeExerciseWeb.FallbackController

  def index(conn, params) do
    users_with_salaries =
      Accounts.get_users_list_with_salaries(
        params["filter_name"],
        params["order_by"],
        params["limit"],
        params["offset"]
      )

    render(conn, :index, users_with_salaries: users_with_salaries)
  end

  def invite_users(conn, _params) do
    users_with_active_salaries = Accounts.get_users_with_active_salaries()

    successful_emails =
      Enum.reduce(users_with_active_salaries, 0, fn (%{user: user}, acc) ->
        case BEChallengex.send_email(%{name: user.name}) do
          {:ok, _name} -> acc + 1
          {:error, :econnrefused} -> Logger.error("There was an error sending email to #{user.name}")
        end
      end)

    render(conn, :emails_sent, emails_sent: successful_emails)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, _user} <- Accounts.create_user(user_params) do
      render(conn, :show_ok)
    end
  end

  def show(conn, %{"id" => id}) do
    case Repo.get(User, id) do
      nil ->
        {:error, :not_found}

      user ->
        {:ok, user}
        user_with_salaries = Repo.preload(user, :salaries)
        render(conn, :show, user: user_with_salaries)
    end
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, :show, user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
