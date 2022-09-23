defmodule Spiral do
  @doc """
  Given the dimension, return a square matrix of numbers in clockwise spiral order.
  """
  @spec matrix(dimension :: integer) :: list(list(integer))
  def matrix(dimension) do
    case dimension do
      0 -> []
      _ -> :math.pow(dimension,2)
           |> Enum.to_list
           |> to_matrix(dimension)
    end

  end

# Enum.map(1..4, fn x -> Enum.map(1..4, fn y ->{x,y} end) end)
# list |> Enum.at(3) |> Enum.at(0)

  def to_matrix(range, dimension) do
    for y <- 1..dimension do
      for x <- 1..dimension do
         x*y
      end
    end
  end
end

IO.inspect(Spiral.matrix((3)))
