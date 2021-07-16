defmodule Bowling do
  defp throw_pin_count_error, do: {:error, "Pin count exceeds pins on the lane"}
  defp throw_negative_pin_error, do: {:error, "Negative roll is invalid"}

  defp throw_unfinished_game_error,
    do: {:error, "Score cannot be taken until the end of the game"}

  defp throw_end_of_game_error, do: {:error, "Cannot roll after game is over"}

  @doc """
    Creates a new game of bowling that can be used to store the results of
    the game
  """

  @spec start() :: any
  def start do
    []
  end

  @doc """
    Records the number of pins knocked down on a single roll. Returns `any`
    unless there is something wrong with the given number of pins, in which
    case it returns a helpful message.
  """

  @spec roll(any, integer) :: any | String.t()
  def roll(_, roll) when roll < 0, do: throw_negative_pin_error()
  def roll(_, roll) when roll > 10, do: throw_pin_count_error()

  def roll([], roll), do: new_frame([], roll)

  def roll(game, roll) do
    [recent | prerecent] = game

    game
    # |> IO.inspect
    |> update_strike(roll, prerecent)
    |> handle_frame(roll, recent)
  end

  # handle frames 1 to 9
  def handle_frame(game, roll, {:new_frame, score}),
    do: update_frame(game, {:new_frame, score + roll})

  def handle_frame(game, roll, {:open_frame, _score}), do: new_frame(game, roll)

  def handle_frame(game, roll, {atom, score}),
    do: update_frame(game, {atom, score + roll}) |> new_frame(roll)

  # handle last frame
  def handle_frame(game, roll, {:new_frame, score, 0}),
    do: update_frame(game, {:new_frame, score + roll, 0})

  def handle_frame(game, roll, {atom, score, pins}),
    do: update_frame(game, {atom, score + roll, pins - roll})

  # second throw within the current frame
  def update_frame(game, {:new_frame, score}) do
    cond do
      score == 10 -> List.replace_at(game, 0, {:spare, 10})
      score < 10 -> List.replace_at(game, 0, {:open_frame, score})
      score > 10 -> throw_pin_count_error()
    end
  end

  # current throw is added to recent strike | spare
  def update_frame(game, {atom, score}), do: List.replace_at(game, 0, {atom, score})
  # update last frame
  def update_frame(_game, {_result, _score, pins}) when pins < 0, do: throw_pin_count_error()
  def update_frame(game, {:new_frame, 10, 0}), do: List.replace_at(game, 0, {:spare, 10, 10})

  def update_frame(game, {:new_frame, score, 0}),
    do: List.replace_at(game, 0, {:open_frame, score, 0})

  def update_frame(_game, {:open_frame, _, _}), do: throw_end_of_game_error()

  def update_frame(game, {:spare, score, pins}),
    do: List.replace_at(game, 0, {:finished_spare, score, pins})

  def update_frame(_game, {:finished_spare, _, _}), do: throw_end_of_game_error()
  def update_frame(game, {:strike, 20, 0}), do: List.replace_at(game, 0, {:second_strike, 20, 10})

  def update_frame(game, {:strike, score, pins}),
    do: List.replace_at(game, 0, {:second_after_strike, score, pins})

  def update_frame(game, {:second_after_strike, score, pins}),
    do: List.replace_at(game, 0, {:finished_strike, score, pins})

  def update_frame(_game, {:finished_strike, _, _}), do: throw_end_of_game_error()
  def update_frame(game, {atom, score, pins}), do: List.replace_at(game, 0, {atom, score, pins})

  # a new frame is started with a strike?
  def new_frame(game, _roll) when length(game) == 10, do: throw_end_of_game_error()
  def new_frame(game, 10) when length(game) == 9, do: [{:strike, 10, 10} | game]
  def new_frame(game, roll) when length(game) == 9, do: [{:new_frame, roll, 0} | game]
  def new_frame(game, 10), do: [{:strike, 10} | game]
  def new_frame(game, roll), do: [{:new_frame, roll} | game]

  # current throw is added to the previous recent strike
  def update_strike(game, roll, [{:strike, score} | _]) when score < 30 do
    List.replace_at(game, 1, {:strike, score + roll})
  end

  def update_strike(game, _, _), do: game

  @doc """
    Returns the score of a given game of bowling if the game is complete.
    If the game isn't complete, it returns a helpful message.
  """

  @spec score(any) :: integer | String.t()
  def score(game) when length(game) < 10, do: throw_unfinished_game_error()

  def score(game) do
    [{result, score, _pins} | regular_frames] = game
    # IO.inspect(game, label: "#{[score,pins]}")
    cond do
      result == :strike and score == 10 -> throw_unfinished_game_error()
      result == :spare -> throw_unfinished_game_error()
      result == :second_strike and score == 20 -> throw_unfinished_game_error()
      true -> Enum.reduce(regular_frames, score, fn {_, score}, agg -> agg + score end)
    end
  end
end
