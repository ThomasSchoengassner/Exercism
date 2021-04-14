defmodule RnaTranscription do


  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  Given a DNA strand, return its RNA complement
  The four nucleotides found in DNA are:
    adenine (A)
    cytosine (C)
    guanine (G)
    thymine (T)
  The four nucleotides found in RNA are:
    adenine (A)
    cytosine (C)
    guanine (G)
    uracil (U).

  ## Examples

  iex> RnaTranscription.to_rna('ACTG')
  'UGAC'
  """
  def transcription(?A), do: ?U
  def transcription(?C), do: ?G
  def transcription(?G), do: ?C
  def transcription(?T), do: ?A

  # def transcription(dna) do
  #   transcriptionMap = %{
  #     # 'A' => 'U'
  #     65 => 85,
  #     #'C' => 'G'
  #     67 => 71,
  #     #'G' => 'C'
  #     71 => 67,
  #     #'T' => 'A'
  #     84 => 65
  #   }
  #   transcriptionMap[dna]
  # end

  @spec to_rna(any) :: list
  def to_rna(dna) do
    Enum.map(dna, &transcription/1)
  end


#  #@spec to_rna([char]) :: [char]
#  def to_rna(dna) do
#    dna_string = to_string(dna)
#    dna_list = String.split(dna_string,"",trim: true)
#    for r <- dna_list do
#          case r do
#            "A" -> "U"
#            "C" -> "G"
#            "G" -> "C"
#            "T" -> "A"
#          end
#        end |> List.to_string |> to_charlist()
#  end

end


dna = 'ATTCTG'
IO.inspect(dna)
IO.inspect(RnaTranscription.to_rna(dna))
