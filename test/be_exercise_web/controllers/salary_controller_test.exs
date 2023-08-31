defmodule BeExerciseWeb.SalaryControllerTest do
  use BeExerciseWeb.ConnCase

  import BeExercise.FinancesFixtures

  alias BeExercise.Finances.Salary

  @create_attrs %{
    active: true,
    id: 42,
    currency: "some currency",
    amount: "120.5"
  }
  @update_attrs %{
    active: false,
    id: 43,
    currency: "some updated currency",
    amount: "456.7"
  }
  @invalid_attrs %{active: nil, id: nil, currency: nil, amount: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all salaries", %{conn: conn} do
      conn = get(conn, ~p"/api/salaries")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create salary" do
    test "renders salary when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/salaries", salary: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/salaries/#{id}")

      assert %{
               "id" => ^id,
               "active" => true,
               "amount" => "120.5",
               "currency" => "some currency",
               "id" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/salaries", salary: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update salary" do
    setup [:create_salary]

    test "renders salary when data is valid", %{conn: conn, salary: %Salary{id: id} = salary} do
      conn = put(conn, ~p"/api/salaries/#{salary}", salary: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/salaries/#{id}")

      assert %{
               "id" => ^id,
               "active" => false,
               "amount" => "456.7",
               "currency" => "some updated currency",
               "id" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, salary: salary} do
      conn = put(conn, ~p"/api/salaries/#{salary}", salary: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete salary" do
    setup [:create_salary]

    test "deletes chosen salary", %{conn: conn, salary: salary} do
      conn = delete(conn, ~p"/api/salaries/#{salary}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/salaries/#{salary}")
      end
    end
  end

  defp create_salary(_) do
    salary = salary_fixture()
    %{salary: salary}
  end
end
