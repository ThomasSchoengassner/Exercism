defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  defp investigate_kind(true, true, true), do: :equilateral
  defp investigate_kind(true, false, false), do: :isosceles
  defp investigate_kind(false, true, false), do: :isosceles
  defp investigate_kind(false, false, true), do: :isosceles
  defp investigate_kind(false, false, false), do: :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: {:ok, kind} | {:error, String.t()}
  def kind(a, b, c) do
    noTriangle? = &(&1 + &2 < &3 || &2 + &3 < &1 || &3 + &1 < &2)
    zeroArea? = &(&1 + &2 == &3 || &2 + &3 == &1 || &3 + &1 == &2)

    cond do
      Enum.any?([a, b, c], fn x -> x <= 0 end) -> {:error, "all side lengths must be positive"}
      noTriangle?.(a, b, c) -> {:error, "side lengths violate triangle inequality"}
      zeroArea?.(a, b, c) -> {:ok, "degenerate triangle"}
      true -> {:ok, investigate_kind(a == b, b == c, c == a)}
    end
  end
end
