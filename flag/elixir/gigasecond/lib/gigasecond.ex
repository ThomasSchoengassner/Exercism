defmodule Gigasecond do
  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @seconds 1.0e9 |> round

  def new_date(year, month, day) do
    {:ok, date} = Date.new!(year, month, day)
    date
  end

  # def new
  # @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) ::
  #         :calendar.datetime()

  def from({{year, month, day}, {hours, minutes, seconds}}) do
    date = Date.new!(year, month, day)
    time = Time.new!(hours, minutes, seconds)

    [year2, month2, day2, hours2, minutes2, seconds2] =
      DateTime.new!(date, time)
      |> DateTime.add(@seconds, :second)
      |> DateTime.to_iso8601()
      |> String.split(~r/[-T:Z]/u, trim: true)
      |> Enum.map(&String.to_integer/1)

    {{year2, month2, day2}, {hours2, minutes2, seconds2}}
  end
end
