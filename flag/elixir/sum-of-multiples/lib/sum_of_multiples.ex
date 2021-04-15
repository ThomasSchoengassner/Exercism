defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """

  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    list = for f <- factors, n <- 1..(limit - 1), rem(n, f) == 0, do: n

    list
    |> Enum.uniq()
    |> Enum.sum()

    # for x <- 1..(limit - 1), Enum.find(factors, &(rem(x, &1) == 0)), reduce: 0 do
    #  acc -> acc + x
    # end
  end
end

IO.inspect(SumOfMultiples.to(20, [3, 5]), label: "Test")
