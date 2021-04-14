defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """

  # functions for decoding the string
  defp pattern([head | tail], 0, ""), do: pattern(tail, 1, head, "")
  defp pattern([], 0, ""), do: ""

  defp pattern([head | tail], acc, old, new) do
    cond do
      old == head -> pattern(tail, acc + 1, head, new)
      old != head and acc == 1 -> pattern(tail, 1, head, new <> old)
      true -> pattern(tail, 1, head, new <> Integer.to_string(acc) <> old)
    end
  end

  defp pattern([], 1, old, new), do: new <> old
  defp pattern([], acc, old, new), do: new <> Integer.to_string(acc) <> old

  @spec encode(String.t()) :: String.t()
  def encode(string) do
    string
    |> String.split("", trim: true)
    |> pattern(0, "")
  end

  # functions for encoding the string
  defp expand([x]), do: x
  defp expand([n, x]), do: String.duplicate(x, String.to_integer(n))

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    string
    |> String.split(~r/(?<=([A-Za-z]|\s))/, trim: true)
    |> Enum.reduce("", fn x, acc ->
      acc <> expand(String.split(x, ~r/[A-Za-z\s]/, include_captures: true, trim: true))
    end)
  end
end

string = "AAABBACCCABB"
IO.inspect(RunLengthEncoder.encode(string), label: "#{string}")

string = ""
IO.inspect(RunLengthEncoder.encode(string), label: "#{string}")

string = "4AB3sC8DA"
IO.inspect(RunLengthEncoder.decode(string), label: "#{string}")

string = "xyz"
IO.inspect(RunLengthEncoder.decode(string), label: "#{string}")
