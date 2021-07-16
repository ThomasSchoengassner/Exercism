defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @weekdays %{
    monday: 1,
    tuesday: 2,
    wednesday: 3,
    thursday: 4,
    friday: 5,
    saturday: 6,
    sunday: 7
  }

  @type weekday ::
          :monday
          | :tuesday
          | :wednesday
          | :thursday
          | :friday
          | :saturday
          | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """

  def select_date(list, :first), do: List.first(list)
  def select_date(list, :second), do: Enum.at(list, 1)
  def select_date(list, :third), do: Enum.at(list, 2)
  def select_date(list, :fourth), do: Enum.at(list, 3)
  def select_date(list, :last), do: List.last(list)

  def select_date(list, :teenth) do
    [{y, m, d}] =
      list
      |> Enum.map(&Date.to_erl(&1))
      |> Enum.filter(fn {_y, _m, d} -> d >= 13 and d <= 19 end)

    {:ok, date} = Date.new(y, m, d)
    date
  end


  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date()
  def meetup(year, month, weekday, schedule) do
    {:ok, first_date} = Date.new(year, month, 1)
    last_day = Date.days_in_month(first_date)
    {:ok, last_date} = Date.new(year, month, last_day)

    Date.range(first_date, last_date)
    |> Enum.map(fn date -> {date, Date.day_of_week(date, :monday)} end)
    |> Enum.filter(fn {_date, wd} -> wd == @weekdays[weekday] end)
    |> Enum.map(&elem(&1, 0))
    |> select_date(schedule)
  end
end

# {year, month, weekday, schedule} = {2021, 02, :sunday, :first}
# IO.inspect(Meetup.meetup(year, month, weekday, schedule))

# {year, month, weekday, schedule} = {2015, 07, :tuesday, :teenth}
# IO.inspect(Meetup.meetup(year, month, weekday, schedule))
