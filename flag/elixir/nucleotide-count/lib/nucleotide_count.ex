defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """

  @spec count(charlist(), char()) :: non_neg_integer()
  def count(strand, nucleotide) do
    Enum.count(strand, &(&1 == nucleotide))
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram(charlist()) :: map()
  def histogram(strand) do
    strand_map = %{?A => 0, ?C => 0, ?G => 0, ?T => 0}
    Enum.reduce(strand, strand_map, fn x, acc -> Map.update(acc, x, 1, &(&1 + 1)) end)
  end

  # Use of the global variable @nucleotides <- another solution
  def histogram2(strand) do
    Enum.reduce(strand, zero_initialized_map_from_list(@nucleotides), &update_histogram/2)
  end
  @spec zero_initialized_map_from_list([char]) :: map
  defp zero_initialized_map_from_list(list) do
    Map.new(list, &{&1, 0})
  end

end


strand = 'AATAA'
nucleotide = 'A'
IO.inspect(NucleotideCount.count(strand, ?A), label: [strand, " ", nucleotide])

strand = 'CCCCC'
nucleotide = 'C'
IO.inspect(NucleotideCount.count(strand, ?C), label: [strand, " ", nucleotide])

strand = 'AATACCCCCCCGA'
IO.inspect(NucleotideCount.histogram(strand),label: strand)

strand = 'AATAA'
IO.inspect(NucleotideCount.histogram(strand),label: strand)

strand = ''
IO.inspect(NucleotideCount.histogram(strand),label: strand)
