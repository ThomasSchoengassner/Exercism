defmodule MatchingBrackets do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """

  @matching_brackets %{"}" => "{", "]" => "[", ")" => "("}

  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
    Regex.scan(~r/[\{\[\(\)\]\}]/, str)
    |> List.flatten()
    |> Enum.reduce_while([], fn k, acc ->
      cond do
        k in ["{", "(", "["] ->
          {:cont, acc ++ [k]}

        k in ["}", ")", "]"] ->
          if List.last(acc) != @matching_brackets[k],
            do: {:halt, false},
            else: {:cont, List.delete_at(acc, -1)}

        true ->
          {:cont, acc}
      end
    end)
    |> (&==/2).([])
  end
end

# ---------- Inspiration
# check_brackets=~r/((\((?:[^\{\})(\[\]]+|(?R))*+\))|(\[(?:[^\{\})(\[\]]+|(?R))*+\])|(\{(?:[^\{\})(\[\]]+|(?R))*+\}))/
