defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do
    Regex.scan(~r/[[:alpha:]]+/, sentence)
    |> List.to_string()
    |> String.codepoints()
    |> Enum.frequencies()
    |> Map.values()
    |> Enum.all?(fn x -> x == 1 end)
  end
end
