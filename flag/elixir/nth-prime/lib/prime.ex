defmodule Prime do
  @doc """
  Generates the nth prime.
  """

  def find_prime(number, list_of_primes) do
    Enum.filter(list_of_primes, fn x -> rem(number, x) == 0 end)
    |> length
    |> case do
      1 -> number
      _ -> find_prime(number + 1, list_of_primes)
    end
  end

  def next_prime(list_of_primes, count) when count > 0 do
    last = List.first(list_of_primes)
    next = find_prime(last + 1, list_of_primes)
    next_prime([next | list_of_primes], count - 1)
  end

  def next_prime(list_of_primes, 0), do: List.first(list_of_primes)

  def nth(count) when count < 1, do: raise(ArgumentError)

  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) do
    next_prime([1], count)
  end
end

IO.inspect(Prime.nth(1))

IO.inspect(Prime.nth(10))
