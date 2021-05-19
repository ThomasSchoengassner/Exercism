defmodule AllYourBase do
  @doc """
  Given a number in base a, represented as a sequence of digits, converts it to base b,
  or returns nil if either of the bases are less than 2
  """

  def convert(_, base_a, base_b) when base_a < 2 or base_b < 2, do: nil

  def convert([], _base_a, _base_b), do: nil

  @spec convert(list, integer, integer) :: list | nil
  def convert(digits, base_a, base_b) do
    cond do
      Enum.any?(digits, fn digit -> digit < 0 or digit == base_a end) ->
        nil

      Enum.all?(digits, fn digit -> digit == 0 end) ->
        [0]

      true ->
        dec_digit =
          1..length(digits)
          |> Enum.reduce(0, fn exp, acc ->
            acc + Enum.at(digits, -exp) * :math.pow(base_a, exp - 1)
          end)
          |> round

        max_exponent =
          (:math.log(dec_digit) / :math.log(base_b))
          |> floor

        to_new_base(dec_digit, [], base_b, max_exponent)
        |> Enum.reverse()
    end
  end

  def to_new_base(_, new, _base_b, -1), do: new

  def to_new_base(old, new, base_b, exponent) do
    element = :math.pow(base_b, exponent)

    cond do
      element > old ->
        to_new_base(old, [0 | new], base_b, exponent - 1)

      true ->
        value = floor(old / element)

        (old - value * element)
        |> to_new_base([value | new], base_b, exponent - 1)
    end
  end
end

"""
def convert([], _, _), do: nil
def convert(_, a, b) when a < 2 or b < 2, do: nil

def convert(digits, a, b) do
  cond do
    Enum.all?(digits, &(&1 == 0)) -> [0]
    Enum.any?(digits, &(&1 >= a or &1 < 0)) -> nil
    true -> digits |> to_base(a) |> from_base(b)
  end
end

defp to_base(digits, base), do: digits |> Enum.reduce(0, fn v, acc -> acc * base + v end)

defp from_base(0, _), do: []
defp from_base(num, base), do: from_base(div(num, base), base) ++ [rem(num, base)]

"""
