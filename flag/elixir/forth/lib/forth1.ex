defmodule Forth do
  defstruct stack: [], words: %{}

  @opaque evaluator :: %Forth{}

  @doc """
  Create a new evaluator.
  """
  @spec new() :: evaluator
  def new() do
    %Forth{}
  end

  @doc """
  Evaluate an input string, updating the evaluator state.
  """
  @spec eval(evaluator, String.t()) :: evaluator
  def eval(ev, s) do
    tokens = s |> String.downcase() |> String.split(~r/[^[:graph:]]+/u, trim: true)
    eval_token(ev, tokens)
  end

  defp eval_token(%Forth{stack: stack, words: words} = ev, [t | rt] = tokens) when is_binary(t) do
    case Integer.parse(t) do
      {i, ""} ->
        eval_token(%Forth{ev | stack: [i | stack]}, rt)

      _ ->
        case Map.fetch(words, t) do
          {:ok, word_def} ->
            eval_token(ev, Enum.concat(Enum.reverse(word_def), rt))

          :error ->
            eval_known_token(ev, tokens)
        end
    end
  end

  defp eval_token(%Forth{} = ev, []) do
    ev
  end

  defp eval_known_token(%Forth{stack: [b, a | r]} = ev, ["+" | rt]) do
    eval_token(%Forth{ev | stack: [a + b | r]}, rt)
  end

  defp eval_known_token(%Forth{stack: [b, a | r]} = ev, ["-" | rt]) do
    eval_token(%Forth{ev | stack: [a - b | r]}, rt)
  end

  defp eval_known_token(%Forth{stack: [b, a | r]} = ev, ["*" | rt]) do
    eval_token(%Forth{ev | stack: [a * b | r]}, rt)
  end

  defp eval_known_token(%Forth{stack: [0, _a | _r]}, ["/" | _rt]) do
    raise Forth.DivisionByZero
  end

  defp eval_known_token(%Forth{stack: [b, a | r]} = ev, ["/" | rt]) do
    eval_token(%Forth{ev | stack: [div(a, b) | r]}, rt)
  end

  defp eval_known_token(%Forth{stack: []}, ["dup" | _rt]) do
    raise Forth.StackUnderflow
  end

  defp eval_known_token(%Forth{stack: [a | r]} = ev, ["dup" | rt]) do
    eval_token(%Forth{ev | stack: [a, a | r]}, rt)
  end

  defp eval_known_token(%Forth{stack: []}, ["drop" | _rt]) do
    raise Forth.StackUnderflow
  end

  defp eval_known_token(%Forth{stack: [_a | r]} = ev, ["drop" | rt]) do
    eval_token(%Forth{ev | stack: r}, rt)
  end

  defp eval_known_token(%Forth{stack: [b, a | r]} = ev, ["swap" | rt]) do
    eval_token(%Forth{ev | stack: [a, b | r]}, rt)
  end

  defp eval_known_token(%Forth{stack: stack}, ["swap" | _rt]) when is_list(stack) do
    raise Forth.StackUnderflow
  end

  defp eval_known_token(%Forth{stack: [b, a | r]} = ev, ["over" | rt]) do
    eval_token(%Forth{ev | stack: [a, b, a | r]}, rt)
  end

  defp eval_known_token(%Forth{stack: stack}, ["over" | _rt]) when is_list(stack) do
    raise Forth.StackUnderflow
  end

  defp eval_known_token(%Forth{words: words} = ev, [":", word | rt]) do
    case Integer.parse(word) do
      {_i, ""} -> raise Forth.InvalidWord
      _ -> eval_new_word_def(%Forth{ev | words: Map.put(words, word, [])}, word, rt)
    end
  end

  defp eval_known_token(%Forth{}, tokens) when is_list(tokens) do
    raise Forth.UnknownWord
  end

  defp eval_new_word_def(%Forth{} = ev, _word, [";" | rt]) do
    eval_token(ev, rt)
  end

  defp eval_new_word_def(%Forth{} = ev, word, [t | rt]) do
    eval_new_word_def(update_in(ev, [Access.key(:words), Access.key(word)], &[t | &1]), word, rt)
  end

  @doc """
  Return the current stack as a string with the element on top of the stack
  being the rightmost element in the string.
  """
  @spec format_stack(evaluator) :: String.t()
  def format_stack(%Forth{stack: stack}) do
    stack |> Enum.reverse() |> Enum.join(" ")
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
