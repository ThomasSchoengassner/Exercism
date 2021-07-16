defmodule BankAccount do
  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  @typedoc """
  An account handle.
  """

  defstruct balance: 0

  @opaque account :: pid

  @doc """
  Open the bank. Makes the account available.


  Good solution. There are four solutions to this problem:

    GenServer
    Agents
    send/receive
    ets

  There is one choice: do you close the process with the account?

  You have chosen the simplest of the four. Have a look at the other student's solutions.

  Good luck with the next exercise.

  """
  @spec open_bank() :: account
  def open_bank() do
    {:ok, account} = Agent.start_link(fn -> %BankAccount{} end)
    account
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: none
  def close_bank(account) do
    Agent.stop(account)
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(account) do
    case Process.alive?(account) do
      true -> Agent.get(account, & &1.balance)
      false -> {:error, :account_closed}
    end
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(account, amount) do
    case Process.alive?(account) do
      true -> Agent.update(account, fn x -> %BankAccount{balance: x.balance + amount} end)
      false -> {:error, :account_closed}
    end
  end
end
