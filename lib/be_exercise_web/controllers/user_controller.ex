defmodule BeExerciseWeb.UserController do
  use BeExerciseWeb, :controller

  alias BeExercise.Accounts
  alias BeExercise.Accounts.User

  action_fallback BeExerciseWeb.FallbackController

  def index(conn, params) do
    users_with_salaries = Accounts.get_users_list_with_salaries(params["filter"], params["order_by"], params["limit"], params["offset"])
    render(conn, :index, users_with_salaries: users_with_salaries)
  end

  def invite_users(conn, _params) do
    users_with_active_salaries = Accounts.get_users_with_active_salaries()
    for(%{user: user} <- users_with_active_salaries, do: BEChallengex.send_email(%{name: user.name}))
    render(conn, :emails_sent)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> render(:show, user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, :show, user: user)
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
