defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """

  @spec score(String.t()) :: non_neg_integer
  def score(word) do
    func =
      &(Regex.scan(&2, &1)
        |> List.flatten()
        |> length
        |> Kernel.*(&3))

    w = String.upcase(word)

    func.(w, ~r/[AEIOULNRST]/u, 1) +
      func.(w, ~r/[DG]/u, 2) +
      func.(w, ~r/[BCMP]/u, 3) +
      func.(w, ~r/[FHVWY]/u, 4) +
      func.(w, ~r/[K]/u, 5) +
      func.(w, ~r/[JX]/u, 8) +
      func.(w, ~r/[QZ]/u, 10) +
      func.(w, ~r/\s/u, 0)
  end
end

"""
------------------ Alternative
@spec score(String.t()) :: non_neg_integer
def score(word) do
  word_list =
    word
    |> String.trim()
    |> String.upcase()
    |> String.graphemes()

  Enum.reduce(word_list, 0, fn x, acc ->
    cond do
      x in ["A", "E", "I", "O", "U", "L", "N", "R", "S", "T"] -> acc + 1
      x in ["D", "G"] -> acc + 2
      x in ["B", "C", "M", "P"] -> acc + 3
      x in ["F", "H", "V", "W", "Y"] -> acc + 4
      x in ["K"] -> acc + 5
      x in ["J", "X"] -> acc + 8
      x in ["Q", "Z"] -> acc + 10
      true -> acc
    end
  end)
end

---------------------- Alternative 2
@spec score(String.t()) :: non_neg_integer
def score(word) do
  word
  |> String.downcase()
  |> String.graphemes()
  |> Enum.reduce(0, fn letter, acc ->
    acc + Map.get(@letter_values, letter, 0)
  end)
end

"""
