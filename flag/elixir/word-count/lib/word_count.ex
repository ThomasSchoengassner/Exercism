defmodule WordCount do
  @doc """
  Count the number of words in the sentence.
  Given a phrase, count the occurrences of each word in that phrase.
  Words are compared case-insensitively.
  """

  #defp remove_special_characters(sentence), do: Regex.replace(~r/[^a-z0-9äüöß-]/u, sentence, " ")

  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
      |> String.downcase
      #|> remove_special_characters
      |> String.split(~r/[^[:alnum:]-]/u, trim: true)
      |> Enum.reduce(%{}, fn x, acc -> Map.update(acc, x, 1, &(&1 + 1)) end)
  end

end


sentence = "olly, olly come in for free"
IO.inspect(sentence, label: "input")
IO.inspect(WordCount.count(sentence), label: "output")

sentence = "car : carpet as java mit Soße : javascript!!&@$%^&"
sentence = "bären dürfen nörgeln a A A a " <> sentence <> " a,b-23"
IO.inspect(sentence, label: "input")
IO.inspect(WordCount.count(sentence), label: "output")
