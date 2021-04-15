defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """

  defp is_sublist(x, y) do
    cond do
      Enum.take(y, length(x)) === x ->
        true

      length(x) == length(y) ->
        false

      true ->
        [_h | t] = y
        is_sublist(x, t)
    end
  end

  @spec compare(list, list) :: :equal | false | :unequal
  def compare(a, b) do
    len_a = length(a)
    len_b = length(b)

    cond do
      len_a == len_b -> (a === b && :equal) || :unequal
      len_a < len_b -> (is_sublist(a, b) && :sublist) || :unequal
      len_a > len_b -> (is_sublist(b, a) && :superlist) || :unequal
    end
  end
end

"""
---------- Alternative Lösung
def compare(a, b) do
  cond do
    a == b -> :equal
    sublist?(a, b) -> :superlist
    sublist?(b, a) -> :sublist
    true -> :unequal
  end
end

def sublist?([], _), do: false

def sublist?([_ | t] = a, b) do
  List.starts_with?(a, b) or sublist?(t, b)
end

---------- Alte Lösung
defp compare_lists(x1, x2, l1, l2) when l1 < l2 do
  Enum.map(0..Enum.min([l2 - l1, 100]), fn i -> x1 === Enum.slice(x2, i, l1) end)
  |> Enum.any?()
  |> case do
    true -> :sublist
    false -> :unequal
  end
end

defp compare_lists(x1, x2, l1, l2) when l1 > l2 do
  Enum.map(0..Enum.min([l1 - l2, 100]), fn i -> x2 === Enum.slice(x1, i, l2) end)
  |> Enum.any?()
  |> case do
    true -> :superlist
    false -> :unequal
  end
end

defp compare_lists(x1, x2, l1, l2) when l1 == l2 do
  case x1 === x2 do
    true -> :equal
    false -> :unequal
  end
end

def compare(a, b) do
  compare_lists(a, b, length(a), length(b))
end

"""
