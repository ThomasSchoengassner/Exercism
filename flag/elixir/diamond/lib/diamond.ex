defmodule Diamond do
  @doc """
  Given a letter, it prints a diamond starting with 'A',
  with the supplied letter at the widest point.
  """

  @spec draw_line(integer, integer) :: String.t()
  def draw_line(d, l) do
    index = round(65 + (l - 1) / 2 - d)

    0..(l - 1)
    |> Enum.map(fn _x -> 32 end)
    |> List.replace_at(index, d)
    |> List.replace_at(-index - 1, d)
    |> List.to_string()
  end

  @spec build_shape(char) :: String.t()
  def build_shape(letter) do
    size = 2 * (letter - ?A) + 1

    case letter == ?A do
      true ->
        draw_line(letter, size) <> "\n"

      false ->
        Enum.map(?A..letter, & &1)
        |> Enum.concat(Enum.map((letter - 1)..?A, & &1))
        |> Enum.reduce("", &(&2 <> draw_line(&1, size) <> "\n"))
    end
  end
end

# IO.inspect(Diamond.build_shape(?D), label: "D")
