defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """

  def bottles(n) when n > 1, do: to_string(n) <> " bottles of beer"
  def bottles(n) when n == 1, do: "1 bottle of beer"
  def bottles(n) when n == 0, do: "no more bottles of beer"
  def bottles(_), do: "99 bottles of beer"

  def beer_store(n) do
    String.capitalize(bottles(n)) <>
      " on the wall, " <>
      bottles(n) <>
      ".\n" <>
      cond do
        n == 1 -> "Take it down and pass it around, "
        n > 1 -> "Take one down and pass it around, "
        n == 0 -> "Go to the store and buy some more, "
      end <>
      bottles(n - 1) <> " on the wall.\n"
  end

  def verse(number) do
    beer_store(number)
  end

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t()) :: String.t()
  def lyrics(range) do
    for n <- range, reduce: "" do
      acc -> acc <> beer_store(n) <> "\n"
    end
    |> String.replace_trailing("\n\n", "\n")
  end

  def lyrics() do
    for n <- 99..0, reduce: "" do
      acc -> acc <> beer_store(n) <> "\n"
    end
    |> String.replace_trailing("\n\n", "\n")
  end
end
