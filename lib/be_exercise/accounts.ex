defmodule BeExercise.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias BeExercise.Repo

  alias BeExercise.Accounts.User
  alias BeExercise.Finances.Salary

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Returns the list of users with active salaries.

  ## Examples

      iex> get_users_with_active_salaries()
      [%{user_id: 1, salary: 1000, currency: "USD"}, ...]

  """
  def get_users_with_active_salaries do
    active_subquery =
      from s in Salary,
        where: s.active == true,
        select: %{user_id: s.user_id, salary: s.amount, currency: s.currency}

    query =
      from u in User,
        join: s in subquery(active_subquery),
        on: u.id == s.user_id,
        order_by: [asc: :id],
        select: %{user: u, salary: s.salary, currency: s.currency}

    Repo.all(query)
  end

  @doc """
  Returns the list of users with salaries.

  ## Examples

      iex> get_users_list_with_salaries()
      [%{user: %User{}, salary: 1000, currency: "USD"}, ...]
  """
  def get_users_list_with_salaries(
        filter_name \\ nil,
        order_by \\ nil,
        limit \\ nil,
        offset \\ nil
      ) do
    dynamic_order_by =
      if order_by == "name" do
        String.to_atom("name")
      else
        String.to_atom("id")
      end

    limit =
      if limit == nil do
        100
      else
        String.to_integer(limit)
      end

    offset =
      if offset == nil do
        0
      else
        String.to_integer(offset)
      end

    active_subquery =
      from s in Salary,
        where: s.active == true,
        select: %{user_id: s.user_id, salary: s.amount, currency: s.currency}

    active_subquery_single =
      from s in Salary,
        where: s.active == true,
        select: %{user_id: s.user_id}

    passive_subquery =
      from s in Salary,
        where: s.user_id not in subquery(active_subquery_single),
        distinct: s.user_id,
        group_by: [s.user_id, s.amount, s.currency, s.updated_at],
        order_by: [desc: s.updated_at],
        select: %{user_id: s.user_id, salary: s.amount, currency: s.currency}

    query =
      from u in User,
        left_join: s in subquery(active_subquery),
        on: u.id == s.user_id,
        left_join: p in subquery(passive_subquery),
        on: u.id == p.user_id,
        where: ilike(u.name, ^"%#{filter_name}%"),
        order_by: [asc: ^dynamic_order_by],
        select: %{
          user: u,
          salary: fragment("COALESCE(?, ?)", s.salary, p.salary),
          currency: fragment("COALESCE(?, ?)", s.currency, p.currency)
        },
        limit: ^limit,
        offset: ^offset

    Repo.all(query)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end
end
