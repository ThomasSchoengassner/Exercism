defmodule IsbnVerifier do
  @doc """
    Checks if a string is a valid ISBN-10 identifier

    ## Examples

      iex> IsbnVerifier.isbn?("3-598-21507-X")
      true

      iex> IsbnVerifier.isbn?("3-598-2K507-0")
      false

  """
  def check_isbn([], [], digit), do: rem(digit, 11) == 0

  def check_isbn([], _multiply, _digit), do: false

  def check_isbn(_isbn, [], _digit), do: false

  def check_isbn(isbn, multiply, digit) do
    [head_isbn | tail_isbn] = isbn
    [head_multiply | tail_multiply] = multiply

    updated_digit = digit + head_isbn * head_multiply

    check_isbn(tail_isbn, tail_multiply, updated_digit)
  end

  @spec isbn?(String.t()) :: boolean
  def isbn?(isbn) do
    isbn
    |> String.replace("-", "")
    |> (&Regex.scan(~r/^[\d]*\d|X$/u, &1)).()
    |> List.to_string()
    |> String.codepoints()
    |> Enum.map(fn
      "X" -> 10
      x -> String.to_integer(x)
    end)
    # Actually I have a better idea with Enum.zip and Enum.reduce but I decided to keep this way
    |> check_isbn(Enum.to_list(10..1), 0)
  end
end

"""
def isbn?(isbn) do
  products =
    isbn
    |> String.split(~r/-|/, trim: true)
    |> Enum.reverse()
    |> Enum.with_index(1)
    |> Enum.map(fn
      {"X", 1} -> 10
      {digit, index} -> String.to_integer(digit) * index
    end)

  length(products) == 10 and rem(Enum.sum(products), 11) == 0
rescue
  _ -> false
end
"""
