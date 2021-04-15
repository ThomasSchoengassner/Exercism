defmodule Bob do
  @doc """
  Bob answers 'Sure.' if you ask him a question.
  He answers 'Whoa, chill out!' if you yell at him.
  He answers 'Calm down, I know what I'm doing!' if you yell a question at him.
  He says 'Fine. Be that way!' if you address him without actually saying anything.
  He answers 'Whatever.' to anything else.
  Bob's conversational partner is a purist when it comes to written communication
  and always follows normal rules regarding sentence punctuation in English.
  """

  def hey(input) do
    cond do
      Regex.match?(~r/^\s{0,50}$/u, input) -> "Fine. Be that way!"
      Regex.match?(~r/[A-Z]?[[:lower:][:digit:]!OK:)][?|\s]{1,4}$/u, input) -> "Sure."
      Regex.match?(~r/^[[:upper:] 123,!%^*@#$()]+[^3]$/u, input) -> "Whoa, chill out!"
      Regex.match?(~r/[A-Z?]$/u, input) -> "Calm down, I know what I'm doing!"
      true -> "Whatever."
    end
  end
end
