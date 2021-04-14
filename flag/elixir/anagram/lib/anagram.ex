defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """

  defp word_to_map(word) do
    word
    |> String.codepoints()
    |> Enum.frequencies_by(&String.downcase/1)
  end

  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    mapped_base = word_to_map(base)
    for word <- candidates, mapped_base == word_to_map(word) and String.downcase(base) != String.downcase(word), do: word
  end
end


# --- Inspiration - Statt Enum.frequencies
"""
def match(base, candidates) do
  base = String.downcase(base)
  base_map = word_to_map(base)

  Enum.filter(candidates, fn candidate ->
    candidate = String.downcase(candidate)

    !String.equivalent?(base, candidate) &&
      Map.equal?(base_map, word_to_map(candidate))
  end)
end

defp word_to_map(word) do
  String.to_charlist(word)
  |> Enum.reduce(%{}, fn char, char_map ->
    count = Map.get(char_map, char, 0)
    Map.put(char_map, char, count + 1)
  end)
end
"""
