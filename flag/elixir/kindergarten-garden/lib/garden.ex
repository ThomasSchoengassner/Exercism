defmodule Garden do
  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """
  @plants %{
    "R" => :radishes,
    "C" => :clover,
    "G" => :grass,
    "V" => :violets
  }

  @kids [
    "Alice",
    "Bob",
    "Charlie",
    "David",
    "Eve",
    "Fred",
    "Ginny",
    "Harriet",
    "Ileana",
    "Joseph",
    "Kincaid",
    "Larry"
  ]

  def info(info_string) do
    plants = parse_plants(info_string)

    @kids
    |> Enum.map(&String.downcase/1)
    |> Enum.map(&String.to_atom/1)
    |> list_to_map(plants, %{})
  end

  @spec info(String.t(), list) :: map
  def info(info_string, student_names) do
    plants = parse_plants(info_string)

    student_names
    |> Enum.sort(:asc)
    |> list_to_map(plants, %{})
  end

  def parse_plants(string) do
    [upper, lower] = String.split(string, "\n")

    Enum.zip(share_plants(upper), share_plants(lower))
    |> Enum.map(fn x -> Tuple.to_list(x) |> List.flatten() |> List.to_tuple() end)
  end

  def share_plants(string) do
    string
    |> String.codepoints()
    |> Enum.map(fn p -> @plants[p] end)
    |> Enum.chunk_every(2)
  end

  def list_to_map([], _, map), do: map

  def list_to_map(keys, [], map) do
    [kh | kt] = keys
    list_to_map(kt, [], Map.put_new(map, kh, {}))
  end

  def list_to_map(keys, values, map) do
    [kh | kt] = keys
    [vh | vt] = values
    list_to_map(kt, vt, Map.put_new(map, kh, vh))
  end
end


"""
Inspiration: Eine schöne Lösung

  @plants %{"G" => :grass, "C" => :clover, "R" => :radishes, "V" => :violets}
  @students ~w(alice bob charlie david eve fred ginny harriet ileana joseph kincaid larry)a

  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ @students) do
    garden =
      String.split(info_string, "\n")
      |> Enum.map(&String.graphemes/1)
      |> Enum.map(&Enum.chunk_every(&1, 2))
      |> Enum.zip()

    for {name, index} <- (student_names |> Enum.sort() |> Enum.with_index()), into: %{} do
      {name, to_text(Enum.at(garden, index))}
    end
  end

  def to_text(input) when is_tuple(input) do
    input
    |> Tuple.to_list()
    |> Enum.flat_map(& &1)
    |> Enum.map(&Map.get(@plants, &1))
    |> List.to_tuple()
  end

  def to_text(_input) do
    {}
  end

"""
