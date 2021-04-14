defmodule Pow do
  require Integer

  def pow(_, 0), do: 1
  def pow(x, n) when Integer.is_odd(n), do: x * pow(x, n - 1)
  def pow(x, n) do
    result = pow(x, div(n, 2))
    result * result
  end
end

Pow.pow(2, 10000)


Enum.map([1, 2, 3, 4, 5], fn c -> :math.pow(2,c) |> round  end)
