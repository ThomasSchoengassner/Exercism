defmodule Forth do
  @opaque evaluator :: any()
  @spaces [ "\x00", "\x01", "\n", "\t"]

  alias Forth.DivisionByZero
  alias Forth.StackUnderflow
  alias Forth.InvalidWord
  alias Forth.UnknownWord


  ###re work wrong order

  defstruct stack: [], env: %{}
  @doc """
  Create a new evaluator.
  """
  @spec new() :: evaluator
  def new() do
    env = %{
        "+" => {:base_op, fn [y,x] -> [x+y] end, 2},
        "-" => {:base_op, fn [y,x] -> [x-y] end, 2},
        "*" => {:base_op, fn [y,x] -> [x*y] end, 2},
        "/" => {:base_op, fn [y,x] ->
          if y==0, do: (raise DivisionByZero), else: [div(x,y)] end, 2},
        "dup" => {:base_op, fn [x] -> [x,x] end, 1},
        "drop" => {:base_op, fn [_x] -> [] end, 1},
        "swap" => {:base_op, fn [y,x] -> [y,x] end, 2},
        "over" => {:base_op, fn [y,x] -> [x,y,x] end, 2}
    }
    %Forth{} |> Map.put(:env, env )
  end

  @doc """
  Evaluate an input string, updating the evaluator state.
  """
  @spec eval(evaluator, String.t()) :: evaluator
  def eval(%Forth{}=forth, s) when is_bitstring(s) do
    tokens = s
      |> String.downcase()
      |> String.replace(@spaces, " ")
      |> String.split()
      |> Enum.map(&to_token/1)

    eval_token(forth, tokens)
  end

  defp eval_token(forth, []), do: forth
  defp eval_token(forth , [x | xs]) when is_integer(x),
    do: eval_token(push(forth,x), xs)
  defp eval_token(forth, [{:op, name} | xs ]) do

    case Map.get(forth.env, name) do
      {:base_op, op, nb_args} ->
        {args, forth} = pop(forth, nb_args)
        eval_token(forth, op.(args)++xs)
      {:subst, ops} -> eval_token(forth, ops++xs)
      _ -> raise UnknownWord, word: name
    end
  end

  defp eval_token(forth, [:start_word, {:op, name} | ls ]) do
    {word_def, [:end_word | rest]} = Enum.split_while(ls, fn
      :end_word -> false
      _ -> true
    end)
    eval_token(update_env(forth, name, {:subst, word_def}), rest)
  end
  defp eval_token(_forth, [:start_word |  _ ]), do: raise InvalidWord

  defp update_env(%Forth{env: env}=forth, op, op_def),
    do: %Forth{forth | env: Map.put(env, op, op_def)}


  defp to_token(token) do
    cond do
      valid_integer?(token) -> String.to_integer(token)
      token == ":" -> :start_word
      token == ";" -> :end_word
      true -> {:op, token}
    end
  end

  defp valid_integer?(str) when is_bitstring(str),
    do: String.match?(str, ~r/^[[:digit:]]+$/)


  defp push(%Forth{stack: stack}=forth, x),
    do: %Forth{forth | stack: [x|stack] }

  defp pop(%Forth{stack: ls}, nb_el) when length(ls)<nb_el,
    do: raise StackUnderflow
  defp pop(%Forth{stack: ls}=forth, nb_el),
    do: {Enum.take(ls, nb_el),
      %Forth{forth | stack: Enum.drop(ls, nb_el) }}


  @doc """
  Return the current stack as a string with the element on top of the stack
  being the rightmost element in the string.
  """
  @spec format_stack(evaluator) :: String.t()
  def format_stack(%Forth{stack: ls}) do
    ls |> Enum.reverse() |> Enum.join(" ")
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
