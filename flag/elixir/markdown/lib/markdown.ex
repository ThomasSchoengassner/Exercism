defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(m) do
    m
    |> String.split("\n")
    |> Enum.map(fn w -> enclose_with_tag(w, String.first(w)) end)
    |> Enum.join()
    |> String.replace("<li>", "<ul><li>", global: false)
    |> String.replace_suffix("</li>", "</li></ul>")
  end

  defp enclose_with_tag(w, "#") do
    [h | t] = String.split(w)
    {hl, htl} = {to_string(String.length(h)), Enum.join(t, " ")}
    "<h#{hl}>#{htl}</h#{hl}>"
  end

  defp enclose_with_tag(w, "*") do
    t = String.split(w, "* ", trim: true)
    "<li>" <> join_words_with_tags(t) <> "</li>"
  end

  defp enclose_with_tag(w, _) do
    t = String.split(w)
    "<p>" <> join_words_with_tags(t) <> "</p>"
  end

  defp join_words_with_tags(t) do
    t
    |> Enum.map(&replace_md_with_tag/1)
    |> Enum.join(" ")
  end

  defp replace_md_with_tag(w) do
    cond do
      w =~ ~r/^__[[:alpha:] ]+__$/ ->
        String.replace(w, ~r/^(__)([[:alpha:] ]{0,100})(__)$/, "<strong>\\2</strong>")

      w =~ ~r/^_[[:alpha:] ]+_$/ ->
        String.replace(w, ~r/^(_)([[:alpha:] ]{0,100})(_)$/, "<em>\\2</em>")

      w =~ ~r/^__[[:alpha:]]+$/ ->
        String.replace(w, ~r/^(__)([[:alpha:]]+)$/, "<strong>\\2")

      w =~ ~r/^_[[:alpha:]]+$/ ->
        String.replace(w, ~r/^(_)([[:alpha:]]+)$/, "<em>\\2")

      w =~ ~r/^[[:alpha:]]+__$/ ->
        String.replace(w, ~r/^([[:alpha:]]+)(__)$/, "\\1</strong>")

      w =~ ~r/^[[:alpha:]]+_$/ ->
        String.replace(w, ~r/^([[:alpha:]]+)(_)$/, "\\1</em>")

      true ->
        w
    end
  end
end
