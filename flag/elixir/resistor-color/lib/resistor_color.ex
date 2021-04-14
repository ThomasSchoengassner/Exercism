defmodule ResistorColor do

  @moduledoc """
  Resistors have color coded bands, where each color maps to a number.
  The first 2 bands of a resistor have a simple encoding scheme: each color maps to a single number.
  These colors are encoded as follows:

    Black: 0
    Brown: 1
    Red: 2
    Orange: 3
    Yellow: 4
    Green: 5
    Blue: 6
    Violet: 7
    Grey: 8
    White: 9

  Mnemonics map the colors to the numbers, that, when stored as an array,
  happen to map to their index in the array: Better Be Right Or Your Great Big Values Go Wrong.
  """

  @color_map %{
    "black"  => 0,
    "brown"  => 1,
    "red"    => 2,
    "orange" => 3,
    "yellow" => 4,
    "green"  => 5,
    "blue"   => 6,
    "violet" => 7,
    "grey"   => 8,
    "white"  => 9
  }

  @colors [
    black: 0,
    brown: 1,
    red: 2,
    orange: 3,
    yellow: 4,
    green: 5,
    blue: 6,
    violet: 7,
    grey: 8,
    white: 9
   ]

  #@spec colors() :: list(String.t())
  def colors do
    # verkehrte Reihenfolge
    Map.keys(@color_map)
    # richtige Reihenfolge
    Enum.map(@colors, fn {x,_y} -> Atom.to_string(x) end)
  end


  @spec code(String.t()) :: integer()
  def code(color) do
    @color_map[color]
    @colors[String.to_atom(color)]
  end

end
