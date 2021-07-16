defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  defp count([_head | tail], n), do: count(tail, n + 1)
  defp count([], n), do: n

  @spec count(list) :: non_neg_integer
  def count(l) do
    count(l, 0)
  end

  defp mirror([head | tail], list), do: mirror(tail, [head | list])
  defp mirror([], list), do: list

  @spec reverse(list) :: list
  def reverse(l) do
    mirror(l, [])
  end

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    for x <- l do
      f.(x)
    end
  end

  defp check([], _f, n), do: n

  defp check(l, f, n) do
    [x | rest] = l
    n = if f.(x), do: [x | n], else: n
    check(rest, f, n)
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    check(l, f, [])
    |> mirror([])
  end

  @spec aggregate(list, any, any) :: any
  defp aggregate([head | tail], acc, f), do: aggregate(tail, f.(head, acc), f)
  defp aggregate([], acc, _), do: acc

  def reduce(l, acc, f) do
    aggregate(l, acc, f)
  end

  defp add_items(a, [head | tail]), do: add_items([head | a], tail)
  defp add_items(a, []), do: a

  def append(a, b) do
    a
    |> mirror([])
    |> add_items(b)
    |> mirror([])
  end

  defp concat([head | tail], l) do
    l =
      case count(head) do
        0 ->
          l

        1 ->
          add_items(l, head)

        _ ->
          head_list = mirror(head, [])
          add_items(l, head_list)
      end

    concat(tail, l)
  end

  defp concat([], l), do: l

  @spec concat([[any]]) :: [any]
  def concat(ll) do
    ll
    |> mirror([])
    |> concat([])
  end
end
