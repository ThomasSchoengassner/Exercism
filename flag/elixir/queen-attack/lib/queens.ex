defmodule Queens do
  @type t :: %Queens{black: {integer, integer}, white: {integer, integer}}
  defstruct [:white, :black]

  @colors [:white, :black]

  @doc """
  Creates a new set of Queens
  """
  @spec new(Keyword.t()) :: Queens.t()
  def new(opts \\ [])

  def new([]) do
    %Queens{white: {0, 4}, black: {7, 4}}
  end

  def new([{key, {x, y}}]) when key in @colors do
    case Enum.all?([x, y], &(&1 >= 0 && &1 <= 7)) do
      true -> Map.put(%Queens{}, key, {x, y})
      false -> raise ArgumentError
    end
  end

  def new([{_, _}]), do: raise(ArgumentError)

  def new([{_key1, {x, y}}, {_key2, {x, y}}]), do: raise(ArgumentError)

  def new([{key1, {x1, y1}}, {key2, {x2, y2}}]) when key1 in @colors and key2 in @colors do
    case Enum.all?([x1, y1, x2, y2], &(&1 >= 0 && &1 <= 7)) do
      true ->
        %Queens{}
        |> Map.put(key1, {x1, y1})
        |> Map.put(key2, {x2, y2})

      false ->
        raise ArgumentError
    end
  end

  def new([{_, _}, {_, _}]), do: raise(ArgumentError)

  @doc """
  Gives a string representation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(queens) do
    position_white = queens.white
    position_black = queens.black

    for x <- 0..7 do
      for y <- 0..7 do
        cond do
          {x, y} == position_white -> "W"
          {x, y} == position_black -> "B"
          true -> "_"
        end
      end
      |> Enum.join(" ")
    end
    |> Enum.join("\n")
  end

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(queens) do
    try do
      {x1, y1} = queens.white
      {x2, y2} = queens.black

      cond do
        x1 == x2 -> true
        y1 == y2 -> true
        abs(x1 - x2) == abs(y1 - y2) -> true
        true -> false
      end
    rescue
      _e -> false
    end
  end
end
