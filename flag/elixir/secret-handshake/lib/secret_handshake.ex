defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """

  def handshake({1, 0}), do: "wink"
  def handshake({1, 1}), do: "double blink"
  def handshake({1, 2}), do: "close your eyes"
  def handshake({1, 3}), do: "jump"
  def handshake({_, _}), do: nil

  def reverse_handshake(list,count) do
    if count > 16, do: Enum.reverse(list), else: list
  end

  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    code
      |> Integer.digits(2)
      |> Enum.take(-4)
      |> Enum.reverse
      |> Enum.with_index
      |> Enum.filter(fn {x,_y} -> x==1 end)
      |> Enum.map( &SecretHandshake.handshake/1 )
      |> SecretHandshake.reverse_handshake(code)
  end


  # 2. Möglichkeit
  use Bitwise
  def commands2(code) do
    []
    |> handshake(code &&& 0b00001)
    |> handshake(code &&& 0b00010)
    |> handshake(code &&& 0b00100)
    |> handshake(code &&& 0b01000)
    |> handshake(code &&& 0b10000)
  end

  def handshake(list, 0b00001), do: list ++ ["wink"]
  def handshake(list, 0b00010), do: list ++ ["double blink"]
  def handshake(list, 0b00100), do: list ++ ["close your eyes"]
  def handshake(list, 0b01000), do: list ++ ["jump"]
  def handshake(list, 0b10000), do: Enum.reverse(list)
  def handshake(list, _), do: list


  # 3. Möglichkeit
  @setBitCommands %{
    1 => "wink",
    2 => "double blink",
    4 => "close your eyes",
    8 => "jump"
  }

  def commands3(code) do
    actions =
      @setBitCommands
      |> Map.keys()
      |> Enum.filter(fn bit -> (code &&& bit) != 0 end)
      |> Enum.map(fn bit -> @setBitCommands[bit] end)

    case code &&& 16 do
      0 -> actions
      _ -> actions |> Enum.reverse()
    end
  end

end


code = 12
IO.inspect(code, label: "Input ")
IO.inspect(SecretHandshake.commands(code), label: "Output")
IO.inspect2(SecretHandshake.commands2(code), label: "Output")

list = [2,4,6,10,18,45,76]
list |> Enum.filter(&(&1 <= 10)) |> Enum.map(fn x -> x*2 end)
list |> Enum.filter(&(&1 <= 10)) |> Enum.map(&(&1*2))


cmds = ["wink", "double blink", "close your eyes", "jump"]
commands = cmds |> Enum.with_index
IO.inspect(Enum.map(commands, fn c -> elem(c,1) end), label: "test fn")
