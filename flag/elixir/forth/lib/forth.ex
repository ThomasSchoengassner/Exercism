defmodule Forth do
  @opaque evaluator :: Integer.t()

  @doc """
  Create a new evaluator.

  Forth is a stack-based programming language. Implement a very basic evaluator for a small subset of Forth.

  Your evaluator has to support the following words:

      +, -, *, / (integer arithmetic)
      DUP, DROP, SWAP, OVER (stack manipulation)

      SWAP	( n1 n2 — n2 n1 )	Reverses the top two stack items
      DUP	( n — n n )	Duplicates the top stack item
      OVER	( n1 n2 — n1 n2 n1 )	Copies second item to top
      DROP	( n — )	Discards the top stack item

  Your evaluator also has to support defining new words using the customary syntax: : word-name definition ;.

  To keep things simple the only data type you need to support is signed integers of at least 16 bits size.
  """

  @spec new() :: evaluator
  def new() do
    evaluator = %{"DUP" => ["DUP"], "DROP" => ["DROP"], "SWAP" => ["SWAP"], "OVER" => ["OVER"]}

    {:ok, ev} = Agent.start_link(fn -> evaluator end)

    ev
  end

  @doc """
  Evaluate an input string, updating the evaluator state.
  """

  @spec operation(String.t()) :: function
  def operation("+"), do: &(&1 + &2)
  def operation("-"), do: &(&1 - &2)
  def operation("*"), do: &(&1 * &2)
  def operation("/"), do: &(&1 / &2)

  defp arithmetic_operation([_ | []], _op), do: raise(Forth.DivisionByZero, [])

  defp arithmetic_operation([agg | list], op) do
    list
    |> Enum.reduce(agg, &operation(op).(&2, &1))
  catch
    ArithmeticError -> raise(Forth.DivisionByZero, [])
  end

  @spec manipulate(String, [String.t()]) :: [String.t()]
  def manipulate("DROP", []), do: raise(Forth.StackUnderflow, [])
  def manipulate("DUP", []), do: raise(Forth.StackUnderflow, [])
  def manipulate("OVER", list) when length(list) <= 1, do: raise(Forth.StackUnderflow, [])
  def manipulate("SWAP", list) when length(list) <= 1, do: raise(Forth.StackUnderflow, [])
  def manipulate("DROP", list), do: list |> List.pop_at(0) |> elem(1)
  def manipulate("DUP", list), do: [Enum.at(list, 0) | list]
  def manipulate("OVER", list), do: [Enum.at(list, 1) | list]
  def manipulate("SWAP", list), do: [Enum.at(list, 1) | list] |> List.delete_at(2)
  def manipulate(x, []), do: [x]

  @spec eval(evaluator, String.t()) :: evaluator
  def eval(ev, s) do
    cond do
      String.match?(s, ~r{^:\s*\d\s*\d\s*;$}) ->
        inv = String.split(s, [" ", ";", ":"], trim: true) |> hd()
        raise(Forth.InvalidWord, word: inv)

      String.match?(s, ~r{^:.*;$}) ->
        [command | instruction] =
          String.split(s, [" ", ";", ":"], trim: true)
          |> Enum.map(&String.upcase/1)

        Agent.update(ev, Map, :put, [command, instruction], 4000)
        ev

      String.match?(s, ~r{^:\s(.*)\s(.*)\s;\s(.*)$}) ->
        sl = String.split(s, ~r{[:|;|\s]}, trim: true)

        Agent.update(ev, Map, :put, [Enum.at(sl, 0), [Enum.at(sl, 1)]], 4000)

        s_list =
          sl
          |> Enum.at(2)
          |> List.wrap()

        stack_handler([], ev, s_list)

      true ->
        s_list = String.split(s, [" ", <<0>>, <<1>>, "\u1680", "\n", "\t", "\r"], trim: true)
        stack_handler([], ev, s_list)
    end
  end

  @spec stack_handler([String.t()], pid(), [String.t()]) :: [String.t()]
  def stack_handler(s_ev, _ev, []), do: Enum.reverse(s_ev)

  def stack_handler(s_ev, ev, [h | t]) do
    cond do
      String.match?(h, ~r{\d}) ->
        stack_handler([String.to_integer(h) | s_ev], ev, t)

      String.upcase(h) in Agent.get(ev, Map, :keys, [], 4000) ->
        Agent.get(ev, Map, :get, [String.upcase(h)])
        |> Enum.reduce(s_ev, &manipulate(&1, &2))
        |> stack_handler(ev, t)

      String.match?(h, ~r{^[-|\/|*|+]$}) ->
        s_ev
        |> Enum.reverse()
        |> arithmetic_operation(h)
        |> floor
        |> List.wrap()
        |> stack_handler(ev, t)

      true ->
        raise(Forth.UnknownWord, word: h)
    end
  end

  @doc """
  Return the current stack as a string with the element on top of the stack
  being the rightmost element in the string.
  """
  @spec format_stack(evaluator) :: String.t()
  def format_stack(ev) do
    case is_list(ev) do
      true -> Enum.join(ev, " ")
      false -> ""
    end
  end

  defmodule StackUnderflow do
    defexception []
    def message(_), do: "stack underflow"
  end

  defmodule InvalidWord do
    defexception word: nil
    def message(e), do: "invalid word: #{inspect(e.word)}"
  end

  defmodule UnknownWord do
    defexception word: nil
    def message(e), do: "unknown word: #{inspect(e.word)}"
  end

  defmodule DivisionByZero do
    defexception []
    def message(_), do: "division by zero"
  end
end
