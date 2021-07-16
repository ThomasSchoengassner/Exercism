defmodule Tournament do
  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do
    table =
      parse_match(input, %{})
      |> Map.values()
      |> Enum.sort_by(&elem(&1, 5), :desc)

    (outcome_table() <>
       (for {t, m, w, d, l, p} <- table do
          outcome_table(t, m, w, d, l, p)
        end
        |> List.to_string()))
    |> String.trim()
  end

  def parse_match([], teams), do: teams

  def parse_match(matches, teams) do
    [match | rest] = matches

    try do
      [home, away, result] = String.split(match, ";")

      teams =
        case result do
          "win" ->
            teams
            |> Map.update(home, {home, 0, 0, 0, 0, 0}, fn x -> x end)
            |> Map.update(away, {away, 0, 0, 0, 0, 0}, fn x -> x end)
            |> Map.update!(home, fn {t, m, w, d, l, p} -> {t, m + 1, w + 1, d, l, p + 3} end)
            |> Map.update!(away, fn {t, m, w, d, l, p} -> {t, m + 1, w, d, l + 1, p} end)

          "draw" ->
            teams
            |> Map.update(home, {home, 0, 0, 0, 0, 0}, fn x -> x end)
            |> Map.update(away, {away, 0, 0, 0, 0, 0}, fn x -> x end)
            |> Map.update!(home, fn {t, m, w, d, l, p} -> {t, m + 1, w, d + 1, l, p + 1} end)
            |> Map.update!(away, fn {t, m, w, d, l, p} -> {t, m + 1, w, d + 1, l, p + 1} end)

          "loss" ->
            teams
            |> Map.update(home, {home, 0, 0, 0, 0, 0}, fn x -> x end)
            |> Map.update(away, {away, 0, 0, 0, 0, 0}, fn x -> x end)
            |> Map.update!(home, fn {t, m, w, d, l, p} -> {t, m + 1, w, d, l + 1, p} end)
            |> Map.update!(away, fn {t, m, w, d, l, p} -> {t, m + 1, w + 1, d, l, p + 3} end)

          _ ->
            teams
        end

      parse_match(rest, teams)
    rescue
      MatchError -> parse_match(rest, teams)
    end
  end

  def outcome_table(team \\ "Team", m \\ "MP", w \\ "W", d \\ "D", l \\ "L", p \\ "P") do
    String.pad_trailing(team, 30) <>
      " | " <>
      String.pad_leading(to_string(m), 2) <>
      " | " <>
      String.pad_leading(to_string(w), 2) <>
      " | " <>
      String.pad_leading(to_string(d), 2) <>
      " | " <>
      String.pad_leading(to_string(l), 2) <>
      " | " <>
      String.pad_leading(to_string(p), 2) <> "\n"
  end
end

# input = [
#   "Allegoric Alaskans;Blithering Badgers;win",
#   "Devastating Donkeys;Courageous Californians;win",
#   "Devastating Donkeys;Allegoric Alaskans;draw",
#   "Courageous Californians;Blithering Badgers;loss",
#   "Blithering Badgers;Devastating Donkeys;loss",
#   "Allegoric Alaskans;Courageous Californians;win"
# ]

# IO.inspect(Tournament.tally(input))
