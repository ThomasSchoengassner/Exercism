defmodule Forth do
  @opaque evaluator :: Integer.t()

  defstruct DUP: ["DUP"], DROP: ["DROP"], SWAP: ["SWAP"], OVER: ["OVER"]

  @val 12
  @words ~w(DUP DROP SWAP OVER)
  @digits ~w(1 2 3 4 5 6 7 8 9)
  @operators ~w(+ - * /)

  defp operation("+"), do: &(&1 + &2)
  defp operation("-"), do: &(&1 - &2)
  defp operation("*"), do: &(&1 * &2)
  defp operation("/"), do: &(&1 / &2)

  defp aggregate(_agg, [], _func), do: raise(Forth.DivisionByZero, [])
  defp aggregate(agg, list, func), do: Enum.reduce(list, agg, fn x, agg -> func.(agg, x) end)

  defp manipulate(_word, []), do: raise(Forth.StackUnderflow, [])
  defp manipulate(word, list) when length(list) == 1 and word in ["SWAP", "OVER"], do: raise(Forth.StackUnderflow, [])
  defp manipulate("DUP", list), do: [Enum.at(list, 0) | list]
  defp manipulate("DROP", list), do: list |> List.pop_at(0) |> elem(1)
  defp manipulate("SWAP", list), do: [Enum.at(list, 1) | list] |> List.delete_at(2)
  defp manipulate("OVER", list), do: [Enum.at(list, 1) | list]

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
    IO.inspect(%Forth{DUP: "OVER"}, label: "***********************")
    IO.inspect(@val+12)
    @val = @val * 100
    IO.inspect(@val+12)

    #%{ Forth | DROP: ["DUP"]}

    []
  end

  @doc """
  Evaluate an input string, updating the evaluator state.
  """
  @spec eval(evaluator, String.t()) :: evaluator
  # def eval(ev, ""), do: Enum.reverse(ev)

  def eval(ev, s) do
    IO.inspect(%Forth{}, label: "-----------------------")

    s
    |> String.split([" ", <<0>>, <<1>>, "\u1680", "\n", "\t", "\r"])
    |> (&stack_handler(ev, &1)).()
  end

  def stack_handler(ev, []), do: Enum.reverse(ev)

  def stack_handler(ev, [h | t]) do
    #IO.inspect(h, label: "\n")
    #IO.inspect(t)
    cond do
      h in @digits ->
        stack_handler([String.to_integer(h) | ev], t)

      h in @operators ->
        [agg | list] = Enum.reverse(ev)

        aggregate(agg, list, operation(h))
        |> floor
        |> List.wrap()
        |> stack_handler(t)

      String.upcase(h) in @words ->
        manipulate(String.upcase(h), ev)
        |> stack_handler(t)

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
    Enum.join(ev, " ")
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
