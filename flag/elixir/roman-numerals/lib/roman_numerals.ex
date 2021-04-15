defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  The Romans wrote numbers using letters - I, V, X, L, C, D, M.
  1    -> I
  5    -> V
  10   -> X
  50   -> L
  100  -> C
  500  -> D
  1000 -> M
  """

  # conversion map digits -> Roman numbers
  @conversionMap %{
     1 => "I",
     5 => "V",
    10 => "X",
    50 => "L",
   100 => "C",
   500 => "D",
  1000 => "M"
   }


  # matching 9, 90, 9000
  defp roman(9, string, scale) do
    @conversionMap[1*scale] <> @conversionMap[10*scale] <> string
  end
  # matching 5 - 8, 50 - 80, and 500 - 8000
  defp roman(digit, string, scale) when digit >= 5 do
    digit = digit - 5
    roman(digit, @conversionMap[5*scale] <> string, scale)
  end
  # matching 4, 40, and 400
  defp roman(4, string, scale) do
    @conversionMap[1*scale] <> @conversionMap[5*scale] <> string
  end
  # matching 1 - 3, 10 - 30, 100 - 300, and 1000 - 3000
  defp roman(digit, string, scale) when digit > 0 do
    string <> String.duplicate(@conversionMap[1*scale],digit)
  end
  # matching default
  defp roman(_, string, _), do: string


  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do

    # Split number up in 1s, 10s, 100s, and 1000s
    digits = number
      |> Integer.digits(10)
      |> Enum.reverse
      |> Enum.zip([1, 10, 100, 1000])
    # Convert digits to Roman numerics
    Enum.map(digits, fn {digit, scale} -> roman(digit,"",scale) end)
      |> Enum.reverse
      |> List.to_string

  end

end

"""
Good solution

There are three solutions to this problem:

    Recursive
    Decimal
    Expand and reduce

Have a look at other students solutions.

Good luck with the next exercise.
"""

# defmodule RomanNumerals do
#   @doc """
#   Convert the number to a roman number.
#   """
#   @spec numeral(pos_integer) :: String.t()
#   def numeral(0), do: ""
#   def numeral(number) when number <= 3000 and number > 0 do
#     nums(number, 0)
#   end

#   @spec nums(non_neg_integer(), non_neg_integer()) :: String.t()
#   defp nums(0, _), do: ""
#   defp nums(number, mag) do
#     nums(div(number, 10), mag + 1) <> romanize(rem(number, 10), magnitude(mag))
#   end

#   @spec romanize(non_neg_integer(), {char, char, char}) :: String.t()
#   defp romanize(n, {one, five, ten}) when n >= 0 and n < 10 do
#     case n do
#       0 -> ""
#       1 -> <<one>>
#       2 -> <<one, one>>
#       3 -> <<one, one, one>>
#       4 -> <<one, five>>
#       5 -> <<five>>
#       6 -> <<five, one>>
#       7 -> <<five, one, one>>
#       8 -> <<five, one, one, one>>
#       9 -> <<one, ten>>
#     end
#   end

#   @spec magnitude(non_neg_integer()) :: {char, char, char}
#   defp magnitude(0), do: {?I, ?V, ?X}
#   defp magnitude(1), do: {?X, ?L, ?C}
#   defp magnitude(2), do: {?C, ?D, ?M}
#   defp magnitude(3), do: {?M, ??, ?!}
# end
