defmodule RobotSimulator do
  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """

  def create(direction \\ :north, position \\ {0, 0})

  def create(_, nil) do
    {:error, "invalid position"}
  end

  def create(d, p) do
    valid_direction = is_atom(d) and d != :invalid

    valid_position =
      is_tuple(p) and tuple_size(p) == 2 and Enum.all?(Tuple.to_list(p), &is_integer(&1))

    cond do
      valid_direction == false -> {:error, "invalid direction"}
      valid_position == false -> {:error, "invalid position"}
      true -> %{direction: d, position: p}
    end
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """

  def move_robot([head | tail], robot) do
    case {robot, head} do
      {%{direction: :north, position: {x, y}}, "A"} ->
        move_robot(tail, %{direction: :north, position: {x, y + 1}})

      {%{direction: :north, position: {x, y}}, "L"} ->
        move_robot(tail, %{direction: :west, position: {x, y}})

      {%{direction: :north, position: {x, y}}, "R"} ->
        move_robot(tail, %{direction: :east, position: {x, y}})

      {%{direction: :east, position: {x, y}}, "A"} ->
        move_robot(tail, %{direction: :east, position: {x + 1, y}})

      {%{direction: :east, position: {x, y}}, "L"} ->
        move_robot(tail, %{direction: :north, position: {x, y}})

      {%{direction: :east, position: {x, y}}, "R"} ->
        move_robot(tail, %{direction: :south, position: {x, y}})

      {%{direction: :south, position: {x, y}}, "A"} ->
        move_robot(tail, %{direction: :south, position: {x, y - 1}})

      {%{direction: :south, position: {x, y}}, "L"} ->
        move_robot(tail, %{direction: :east, position: {x, y}})

      {%{direction: :south, position: {x, y}}, "R"} ->
        move_robot(tail, %{direction: :west, position: {x, y}})

      {%{direction: :west, position: {x, y}}, "A"} ->
        move_robot(tail, %{direction: :west, position: {x - 1, y}})

      {%{direction: :west, position: {x, y}}, "L"} ->
        move_robot(tail, %{direction: :south, position: {x, y}})

      {%{direction: :west, position: {x, y}}, "R"} ->
        move_robot(tail, %{direction: :north, position: {x, y}})

      {_, _} ->
        {:error, "invalid instruction"}
    end
  end

  def move_robot([], robot), do: robot

  # @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    instructions
    |> String.codepoints()
    |> move_robot(robot)
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot) do
    robot.direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(robot) do
    robot.position
  end
end

IO.inspect(RobotSimulator.create())
IO.inspect(RobotSimulator.create(nil, nil))
IO.inspect(RobotSimulator.create(:south, {3, 4}))

robot = RobotSimulator.create(:north, {0, 0}) |> RobotSimulator.simulate("AAAAA")
IO.inspect(robot, label: "robot")

robot =
  RobotSimulator.create(:north, {0, 0})
  |> RobotSimulator.simulate(
    "LAAARALARAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAALAAAAAAAAAAAAAAAAAAAAAAAAA"
  )

IO.inspect(robot, label: "robot")
