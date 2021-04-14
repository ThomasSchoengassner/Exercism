defmodule ProteinTranslation do
  @codon_translation [
    UGU: "Cysteine",
    UGC: "Cysteine",
    UUA: "Leucine",
    UUG: "Leucine",
    AUG: "Methionine",
    UUU: "Phenylalanine",
    UUC: "Phenylalanine",
    UCU: "Serine",
    UCC: "Serine",
    UCA: "Serine",
    UCG: "Serine",
    UGG: "Tryptophan",
    UAU: "Tyrosine",
    UAC: "Tyrosine",
    UAA: "STOP",
    UAG: "STOP",
    UGA: "STOP"
  ]

  defp transfer(codon), do: @codon_translation[String.to_atom(codon)]

  # Given an RNA string, return a list of proteins specified by codons, in order.
  def of_rna(rna) do
    protein_list =
      Regex.scan(~r/\w{3}/, rna)
      |> List.flatten()
      |> Enum.map(&transfer/1)

    nil_index = Enum.find_index(protein_list, fn x -> x == nil end)
    stp_index = Enum.find_index(protein_list, fn x -> x == "STOP" end)

    cond do
      is_integer(nil_index) -> {:error, "invalid RNA"}
      is_integer(stp_index) -> {:ok, Enum.split(protein_list, stp_index) |> elem(0)}
      true -> {:ok, protein_list}
    end
  end

  # Given a codon, return the corresponding protein
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    protein = transfer(codon)

    if is_nil(protein) do
      {:error, "invalid codon"}
    else
      {:ok, protein}
    end
  end
end
