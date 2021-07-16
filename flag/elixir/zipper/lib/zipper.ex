defmodule Zipper do
  import BinTree

  @type t :: %Zipper{level: BinTree, path: []}
  defstruct [:level, :path]

  @doc """
  Get a zipper focused on the root node.
  """
  @spec from_tree(BinTree.t()) :: Zipper.t()
  def from_tree(bin_tree) do
    %Zipper{level: bin_tree, path: []}
  end

  @doc """
  Get the complete tree from a zipper.
  """
  @spec to_tree(Zipper.t()) :: BinTree.t()
  def to_tree(%Zipper{level: level, path: []}), do: level

  def to_tree(zipper) do
    zipper
    |> up
    |> to_tree
  end

  @doc """
  Get the value of the focus node.
  """
  @spec value(Zipper.t()) :: any
  def value(%Zipper{level: %{value: value}}), do: value

  @doc """
  Get the left child of the focus node, if any.
  """
  @spec left(Zipper.t()) :: Zipper.t() | nil
  def left(%{level: %BinTree{left: nil}}), do: nil

  def left(%Zipper{level: %BinTree{value: value, left: left, right: right}, path: path}) do
    %Zipper{level: left, path: [{:left, value, right} | path]}
  end

  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right(Zipper.t()) :: Zipper.t() | nil
  def right(%{level: %BinTree{right: nil}}), do: nil

  def right(%{level: %BinTree{value: value, left: left, right: right}, path: path}) do
    %Zipper{level: right, path: [{left, value, :right} | path]}
  end

  @doc """
  Get the parent of the focus node, if any.
  """
  @spec up(Zipper.t()) :: Zipper.t() | nil
  def up(%Zipper{path: []}), do: nil

  def up(%{level: left, path: [{:left, value, right} | path]}) do
    tree = %BinTree{value: value, left: left, right: right}
    %Zipper{level: tree, path: path}
  end

  def up(%{level: right, path: [{left, value, :right} | path]}) do
    tree = %BinTree{value: value, right: right, left: left}
    %Zipper{level: tree, path: path}
  end

  @doc """
  Set the value of the focus node.
  """
  @spec set_value(Zipper.t(), any) :: Zipper.t()
  def set_value(zipper, value) do
    %Zipper{zipper | level: %{zipper.level | value: value}}
  end

  @doc """
  Replace the left child tree of the focus node.
  """
  @spec set_left(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_left(zipper, left) do
    %Zipper{zipper | level: %{zipper.level | left: left}}
  end

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_right(zipper, right) do
    %Zipper{zipper | level: %{zipper.level | right: right}}
  end
end
