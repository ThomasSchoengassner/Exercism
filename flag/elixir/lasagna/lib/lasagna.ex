defmodule Lasagna do
  # Please define the 'expected_minutes_in_oven/0' function
  @spec expected_minutes_in_oven :: integer()
  def expected_minutes_in_oven, do: 40

  # Please define the 'remaining_minutes_in_oven/1' function
  @spec remaining_minutes_in_oven(integer()) :: integer()
  def remaining_minutes_in_oven(t), do: expected_minutes_in_oven() - t

  # Please define the 'preparation_time_in_minutes/1' function
  @spec preparation_time_in_minutes(integer()) :: integer()
  def preparation_time_in_minutes(p), do: 2 * p

  # Please define the 'total_time_in_minutes/2' function
  @spec total_time_in_minutes(integer(), integer()) :: integer()
  def total_time_in_minutes(p, t), do: preparation_time_in_minutes(p) + t

  # Please define the 'alarm/0' function
  @spec alarm :: String.t()
  def alarm, do: "Ding!"
end
