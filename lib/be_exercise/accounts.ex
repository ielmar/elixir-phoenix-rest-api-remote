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

  def get_users_with_active_salaries(filter_name \\ nil, order_by \\ nil) do
    dynamic_order_by = if order_by == "name" do
      String.to_atom("name")
    else
      String.to_atom("id")
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
      where: s.active == false and s.user_id not in subquery(active_subquery_single),
      distinct: s.user_id,
      select: %{user_id: s.user_id, salary: s.amount, currency: s.currency}

    query =
      from u in User,
      left_join: s in subquery(active_subquery),
      on: u.id == s.user_id,
      left_join: p in subquery(passive_subquery),
      on: u.id == p.user_id,
      where: fragment("LOWER(?) LIKE LOWER(?)", u.name, ^"%#{filter_name}%"),
      order_by: [asc: ^dynamic_order_by],
      select: %{user: u, salary: fragment("COALESCE(?, ?)", s.salary, p.salary), currency: fragment("COALESCE(?, ?)", s.currency, p.currency)}

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
