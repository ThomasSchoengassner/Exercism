defmodule Hexadecimal do
  @doc """
    Accept a string representing a hexadecimal value and returns the
    corresponding decimal value.
    It returns the integer 0 if the hexadecimal is invalid.
    Otherwise returns an integer representing the decimal value.

    ## Examples

      iex> Hexadecimal.to_decimal("invalid")
      0

      iex> Hexadecimal.to_decimal("af")
      175

  """

  @spec to_decimal(binary) :: integer
  def to_decimal(hex) do
    if String.match?(hex, ~r/^[\da-fA-F]*$/) do
      hex
      |> String.downcase
      |> String.split("", trim: true)
      |> Enum.map(fn
        "a" -> 10
        "b" -> 11
        "c" -> 12
        "d" -> 13
        "e" -> 14
        "f" -> 15
        x -> String.to_integer(x)
      end)
      |> Enum.reverse()
      |> Enum.with_index(0)
      |> Enum.reduce(0, fn {hex, pot}, dec -> dec + hex * :math.pow(16,pot) end)
    else
      0
    end
  end
end
