defmodule BeExerciseWeb.SalaryController do
  use BeExerciseWeb, :controller

  alias BeExercise.Finances
  alias BeExercise.Finances.Salary

  action_fallback BeExerciseWeb.FallbackController

  def index(conn, _params) do
    salaries = Finances.list_salaries()
    render(conn, :index, salaries: salaries)
  end

  def create(conn, %{"salary" => salary_params}) do
    with {:ok, %Salary{} = salary} <- Finances.create_salary(salary_params) do
      conn
      |> put_status(:created)
      |> render(:show, salary: salary)
    end
  end

  def show(conn, %{"id" => id}) do
    salary = Finances.get_salary!(id)
    render(conn, :show, salary: salary)
  end

  def update(conn, %{"id" => id, "salary" => salary_params}) do
    salary = Finances.get_salary!(id)

    with {:ok, %Salary{} = salary} <- Finances.update_salary(salary, salary_params) do
      render(conn, :show, salary: salary)
    end
  end

  def delete(conn, %{"id" => id}) do
    salary = Finances.get_salary!(id)

    with {:ok, %Salary{}} <- Finances.delete_salary(salary) do
      send_resp(conn, :no_content, "")
    end
  end
end
