defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer} | {:error, String.t()}
  def hamming_distance(strand1, strand2) do
    {l1, l2} = {length(strand1), length(strand2)}

    cond do
      l1 == l2 ->
        {:ok,
         Enum.reduce_while(0..(l1 - 1), 0, fn i, acc ->
           if Enum.at(strand1, i) != Enum.at(strand2, i) do
             {:cont, acc + 1}
           else
             {:cont, acc}
           end
         end)}

      true ->
        {:error, "Lists must be the same length"}
    end
  end
end
