defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(s, size) do
    len = String.length(s)
    subs = cond do
      size in 1..len -> Enum.map(0..len-size, fn x -> String.slice(s,x,size) end )
      true -> []
    end
    subs
  end
end
