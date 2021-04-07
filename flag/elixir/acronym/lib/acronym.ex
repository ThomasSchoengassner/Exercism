defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """

  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    #scan = &Regex.scan(~r/[A-Z]|[\s][a-z]/u, &1)
    #string
    #|> String.replace("GNU", "Gnu")
    #|> scan.()
    #|> to_string
    #|> String.upcase()
    #|> String.replace(" ", "")

    string
    #|> String.replace(~r/([a-z])([A-Z])/, "\\1 \\2")
    |> String.split(~r/(?=[A-Z][a-z])|[\s_-]/u)
    |> Enum.map(&String.first/1)
    |> Enum.reject(&is_nil/1)
    |> to_string
    |> String.upcase()
  end
end
