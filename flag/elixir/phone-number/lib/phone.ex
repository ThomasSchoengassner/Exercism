defmodule Phone do
  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("212-555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 055-0100")
  "0000000000"

  iex> Phone.number("(212) 555-0100")
  "2125550100"

  iex> Phone.number("867.5309")
  "0000000000"
  """

  @spec number(String.t()) :: String.t()
  def number(raw) do
    num =
      raw
      |> String.splitter(["+", "(", ")", "-", " ", "."], trim: true)
      |> Enum.reduce("", &(&2 <> &1))
      |> String.trim_leading("1")

    valid_phone =
      String.length(num) == 10 and
        String.match?(num, ~r/[a]/) == false and
        String.at(num, 3) not in ["0", "1"] and
        String.at(num, 0) not in ["0", "1"]

    if valid_phone do
      num
    else
      "0000000000"
    end
  end

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("212-555-0100")
  "212"

  iex> Phone.area_code("+1 (212) 555-0100")
  "212"

  iex> Phone.area_code("+1 (012) 555-0100")
  "000"

  iex> Phone.area_code("867.5309")
  "000"
  """

  @spec area_code(String.t()) :: String.t()
  def area_code(raw) do
    num =
      raw
      |> String.trim_leading("1")
      |> String.slice(0..2)

    case String.match?(num, ~r/[2-7]../) do
      true -> num
      false -> "000"
    end
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("212-555-0100")
  "(212) 555-0100"

  iex> Phone.pretty("212-155-0100")
  "(000) 000-0000"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  def make_pretty(new, 10, true) do
    a = String.slice(new, 0, 3)
    m = String.slice(new, 3, 3)
    e = String.slice(new, 6, 4)
    "(#{a}) #{m}-#{e}"
  end

  def make_pretty(_, 0..9, _), do: "(000) 000-0000"

  def make_pretty(_, _, false), do: "(000) 000-0000"

  @spec pretty(String.t()) :: String.t()
  def pretty(raw) do
    new =
      Regex.scan(~r/[0-9]/, raw)
      |> List.to_string()
      |> String.trim_leading("1")

    make_pretty(new, String.length(new), String.match?(new,~r/[2-7]..[2-9]....../))
  end
end
