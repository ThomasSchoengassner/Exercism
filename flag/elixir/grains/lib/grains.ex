defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer) :: pos_integer
  def square(number) do
    case number > 0 && number < 65 do
      true -> {:ok, :math.pow(2, number - 1) |> round}
      false -> {:error, "The requested square must be between 1 and 64 (inclusive)"}
    end
  end

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: pos_integer
  def total do
    {:ok, Enum.reduce(1..64, 0, fn n, t -> t + round(:math.pow(2, n - 1)) end)}
  end
end

# :math.pow(2,number-1)
# |> (&({:ok, round(&1)})).()
