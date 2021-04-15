defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """


  @spec convert(pos_integer) :: String.t()
  def convert(number) do

    drop_table = %{3 => "Pling", 5 => "Plang", 7 => "Plong"}

    drops = for {prime, drop} <- drop_table, rem(number, prime) == 0, do: drop

    case Enum.count(drops) do
      0 -> to_string(number)
      _ -> List.to_string(drops)
    end

  end

end


# defmodule Raindrops do
#   @doc """
#   Returns a string based on raindrop factors.

#   - If the number contains 3 as a prime factor, output 'Pling'.
#   - If the number contains 5 as a prime factor, output 'Plang'.
#   - If the number contains 7 as a prime factor, output 'Plong'.
#   - If the number does not contain 3, 5, or 7 as a prime factor,
#     just pass the number's digits straight through.
#   """
#   @spec convert(pos_integer) :: String.t()
#   def convert(number) do
#     return =
#       factors(number)
#       |> Enum.reduce("", fn factor, return ->
#         case factor do
#           3 -> "Pling"
#           5 -> return <> "Plang"
#           7 -> return <> "Plong"
#           _ -> return
#         end
#       end)

#     if return == "" do
#       to_string(number)
#     else
#       return
#     end
#   end

#   defp factors(1), do: [1]

#   defp factors(n) do
#     for(i <- 1..div(n, 2), rem(n, i) == 0, do: i) ++ [n]
#   end
# end



# defmodule Raindrops do
#   @doc """
#   Returns a string based on raindrop factors.

#   - If the number contains 3 as a prime factor, output 'Pling'.
#   - If the number contains 5 as a prime factor, output 'Plang'.
#   - If the number contains 7 as a prime factor, output 'Plong'.
#   - If the number does not contain 3, 5, or 7 as a prime factor,
#     just pass the number's digits straight through.
#   """
#   @spec convert(pos_integer) :: String.t()
#   def convert(number) do
#     with three <- three(number),
#     five <- five(number),
#     seven <- seven(number) do
#       case three <> five <> seven do
#         "" -> none(number)
#         _ -> three <> five <> seven
#       end
#     end
#   end
#   defp three(number) do
#     case rem(number, 3) do
#       0 -> "Pling"
#       _ -> ""
#     end
#   end
#   defp five(number) do
#     case rem(number, 5) do
#       0 -> "Plang"
#       _ -> ""
#     end
#   end
#   defp seven(number) do
#     case rem(number, 7) do
#       0 -> "Plong"
#       _ -> ""
#     end
#   end
#   defp none(number), do: Integer.to_string(number)
# end
