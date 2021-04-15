defmodule Matrix do
  defstruct matrix: nil

  @doc """
  Convert an `input` string, with rows separated by newlines and values
  separated by single spaces, into a `Matrix` struct.
  """

  @spec from_string(input :: String.t()) :: %Matrix{}
  def from_string(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn x ->
      String.split(x, " ", trim: true)
      |> Enum.map(&String.to_integer/1)
    end)
  end

  @doc """
  Write the `matrix` out as a string, with rows separated by newlines and
  values separated by single spaces.
  """
  @spec to_string(matrix :: %Matrix{}) :: String.t()
  def to_string(matrix) do
    Enum.join(Enum.map(matrix, fn row -> Enum.join(row, " ") end), "\n")
  end

  @doc """
  Given a `matrix`, return its rows as a list of lists of integers.
  """
  @spec rows(matrix :: %Matrix{}) :: list(list(integer))
  def rows(matrix) do
    matrix
  end

  @doc """
  Given a `matrix` and `index`, return the row at `index`.
  """
  @spec row(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def row(matrix, index) do
    matrix
    |> Enum.at(index)
  end

  @doc """
  Given a `matrix`, return its columns as a list of lists of integers.
  """
  @spec columns(matrix :: %Matrix{}) :: list(list(integer))
  def columns(matrix) do
    matrix
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  @doc """
  Given a `matrix` and `index`, return the column at `index`.
  """
  @spec column(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def column(matrix, index) do
    matrix
    |> Matrix.columns()
    |> Enum.at(index)
  end
end


# ---- Inspiration
# def from_string(input) do
#   %__MODULE__{
#     matrix:
#       input
#       |> String.split("\n")
#       |> Enum.map(fn nums ->
#         String.split(nums, " ")
#         |> Enum.map(&String.to_integer(&1))
#       end)
#   }
# end
