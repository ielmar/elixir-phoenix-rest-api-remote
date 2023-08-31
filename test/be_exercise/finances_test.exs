defmodule BeExercise.FinancesTest do
  use BeExercise.DataCase

  alias BeExercise.Finances

  describe "salaries" do
    alias BeExercise.Finances.Salary

    import BeExercise.FinancesFixtures

    @invalid_attrs %{active: nil, currency: nil, amount: nil}

    test "list_salaries/0 returns all salaries" do
      salary = salary_fixture()
      assert Finances.list_salaries() == [salary]
    end

    test "get_salary!/1 returns the salary with given id" do
      salary = salary_fixture()
      assert Finances.get_salary!(salary.id) == salary
    end

    test "create_salary/1 with valid data creates a salary" do
      valid_attrs = %{active: true, currency: "some currency", amount: "120.5"}

      assert {:ok, %Salary{} = salary} = Finances.create_salary(valid_attrs)
      assert salary.active == true
      assert salary.currency == "some currency"
      assert salary.amount == Decimal.new("120.5")
    end

    test "create_salary/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Finances.create_salary(@invalid_attrs)
    end

    test "update_salary/2 with valid data updates the salary" do
      salary = salary_fixture()
      update_attrs = %{active: false, currency: "some updated currency", amount: "456.7"}

      assert {:ok, %Salary{} = salary} = Finances.update_salary(salary, update_attrs)
      assert salary.active == false
      assert salary.currency == "some updated currency"
      assert salary.amount == Decimal.new("456.7")
    end

    test "update_salary/2 with invalid data returns error changeset" do
      salary = salary_fixture()
      assert {:error, %Ecto.Changeset{}} = Finances.update_salary(salary, @invalid_attrs)
      assert salary == Finances.get_salary!(salary.id)
    end

    test "delete_salary/1 deletes the salary" do
      salary = salary_fixture()
      assert {:ok, %Salary{}} = Finances.delete_salary(salary)
      assert_raise Ecto.NoResultsError, fn -> Finances.get_salary!(salary.id) end
    end

    test "change_salary/1 returns a salary changeset" do
      salary = salary_fixture()
      assert %Ecto.Changeset{} = Finances.change_salary(salary)
    end
  end

  describe "salaries" do
    alias BeExercise.Finances.Salary

    import BeExercise.FinancesFixtures

    @invalid_attrs %{active: nil, id: nil, currency: nil, amount: nil}

    test "list_salaries/0 returns all salaries" do
      salary = salary_fixture()
      assert Finances.list_salaries() == [salary]
    end

    test "get_salary!/1 returns the salary with given id" do
      salary = salary_fixture()
      assert Finances.get_salary!(salary.id) == salary
    end

    test "create_salary/1 with valid data creates a salary" do
      valid_attrs = %{active: true, id: 42, currency: "some currency", amount: "120.5"}

      assert {:ok, %Salary{} = salary} = Finances.create_salary(valid_attrs)
      assert salary.active == true
      assert salary.id == 42
      assert salary.currency == "some currency"
      assert salary.amount == Decimal.new("120.5")
    end

    test "create_salary/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Finances.create_salary(@invalid_attrs)
    end

    test "update_salary/2 with valid data updates the salary" do
      salary = salary_fixture()
      update_attrs = %{active: false, id: 43, currency: "some updated currency", amount: "456.7"}

      assert {:ok, %Salary{} = salary} = Finances.update_salary(salary, update_attrs)
      assert salary.active == false
      assert salary.id == 43
      assert salary.currency == "some updated currency"
      assert salary.amount == Decimal.new("456.7")
    end

    test "update_salary/2 with invalid data returns error changeset" do
      salary = salary_fixture()
      assert {:error, %Ecto.Changeset{}} = Finances.update_salary(salary, @invalid_attrs)
      assert salary == Finances.get_salary!(salary.id)
    end

    test "delete_salary/1 deletes the salary" do
      salary = salary_fixture()
      assert {:ok, %Salary{}} = Finances.delete_salary(salary)
      assert_raise Ecto.NoResultsError, fn -> Finances.get_salary!(salary.id) end
    end

    test "change_salary/1 returns a salary changeset" do
      salary = salary_fixture()
      assert %Ecto.Changeset{} = Finances.change_salary(salary)
    end
  end
end
