defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """

  def rot(c1, _) when c1 < ?A, do: c1
  def rot(c1, c2) when c1 <= ?Z and c2 > ?Z, do: c2 - 26
  def rot(c1, c2) when c1 <= ?z and c2 > ?z, do: c2 - 26
  def rot(_, c2), do: c2

  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> to_charlist
    |> Enum.map(&rot(&1, &1 + shift))
    |> to_string
  end
end

# --------------- Alternative Lösung 1
# def rotate(text, shift) do
#   Enum.reduce(String.to_charlist(text), "", &transform(&1, shift, &2))
# end

# defp transform(code, shift, acc) do
#   cond do
#     code in ?a..?z  -> acc <> << ?a + Integer.mod(code - ?a + shift, 26) >>
#     code in ?A..?Z -> acc <> << ?A + Integer.mod(code - ?A + shift, 26) >>
#     true -> acc <> << code >>
#   end
# end

# --------------- Alternative Lösung 2
# @lowercase_latin ?a..?z
# @uppercase_latin ?A..?Z

# @spec rotate(text :: String.t(), shift :: integer) :: String.t()
# def rotate(text, shift) do
#   text
#   |> to_charlist()
#   |> Enum.map(&caesar_shift(&1, shift))
#   |> to_string()
# end

# defp fetch_alphabet(char) do
#   cond do
#     char in @lowercase_latin -> {:ok, @lowercase_latin}
#     char in @uppercase_latin -> {:ok, @uppercase_latin}
#     true -> :error
#   end
# end

# defp caesar_shift(char, shift) do
#   with {:ok, base.._max = alpha} <- fetch_alphabet(char) do
#     base + Integer.mod(char + shift - base, Enum.count(alpha))
#   else
#     _ -> char
#   end
# end

# --------------- Alternative Lösung 3
# @spec rotate(text :: String.t(), shift :: integer) :: String.t()
# def rotate(text, shift) when shift >= 0 do
#   #String.graphemes(text)
#   String.to_charlist(text)
#     |> Enum.reduce([],
#       fn
#         uppercase, acc when uppercase > 64 and uppercase < 91 -> acc ++ [(rem(uppercase - 65 + shift, 26) + 65)]
#         lowercase, acc when lowercase > 96 and lowercase < 123 -> acc ++ [(rem(lowercase - 97 + shift, 26) + 97)]
#         x, acc -> acc ++ [x]
#       end)
#     |> List.to_string
# end
