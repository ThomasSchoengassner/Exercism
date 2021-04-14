defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @cons 'bcdfghjklmnpqrstvwxyz'
  @cons2 'bcdfghjklmnpqrstvwxz'

  def convert(phrase) do
    cond do
      Regex.match?(~r/^[x][r|b]|^[y][t|d]+/u, phrase) ->
        phrase

      Regex.match?(~r/^[#{@cons2}]+[y]+/u, phrase) ->
        String.replace(phrase, ~r/([#{@cons2}]+)([a-z]+)/u, "\\2\\1")

      Regex.match?(~r/^[#{@cons}]?[q][u]+/u, phrase) ->
        String.replace(phrase, ~r/([#{@cons}]?[q][u])([a-z]+)/u, "\\2\\1")

      Regex.match?(~r/^[#{@cons}]+/u, phrase) ->
        String.replace(phrase, ~r/([#{@cons}]+)([a-z]+)/u, "\\2\\1")

      true ->
        phrase
    end <> "ay"
  end

  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split(" ")
    |> Enum.map(&convert/1)
    |> Enum.reduce(fn x, acc -> acc <> " " <> x end)
  end
end

IO.inspect(PigLatin.translate("chair"), label: "chair")
IO.inspect(PigLatin.translate("square"), label: "square")
IO.inspect(PigLatin.translate("rhythm"), label: "rhythm")

# Interessante Sting -> Variablen Zuweisung
<<h::binary-size(1), c::binary-size(1), t::binary>> = "xray" # -> "xray"
IO.inspect({h,c,t}) # -> {"x", "r", [["s", "q"]]}


# defmodule PigLatin do

#   @spec translate(phrase :: String.t()) :: String.t()
#   def translate(phrase) do
#     phrase
#       |> String.split(" ")
#       |> translator
#   end

#   def translator(listed) when length(listed) > 1 do
#     Enum.map_join(listed, " ", &translator([&1]))
#   end

#   def translator(listed) when length(listed) == 1 do
#     phrase = Enum.at(listed, 0)
#     cond do
#       starts_with_vowel?(phrase) -> "#{phrase}ay"
#       true -> consonants(phrase)
#     end
#   end

#   defp starts_with_vowel?(phrase) do
#     String.starts_with?(phrase,  ~w(a e i o u xr xb yt yd))
#   end

#   defp has_qu(list) do
#     [[u| after_u] | t] = list
#     if Enum.at(List.flatten(t), -1) == "q" and u == "u" do
#       [after_u | t ++ [u]]
#     else
#       list
#     end
#   end

#   defp consonants(phrase) do
#     phrase
#       |> String.graphemes()
#       |> Enum.split_while(fn w -> !Enum.member?(~w(a e i o u ), w) end)
#       |> Tuple.to_list
#       |> Enum.reverse
#       |> has_qu
#       |> Enum.concat(["ay"])
#       |> Enum.join
#   end
# end
