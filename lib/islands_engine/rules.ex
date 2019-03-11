defmodule IslandsEngine.Rules do
  @moduledoc """
  Rules for the Island Game

  Starts with :initialized state

  :initialized
    - Can :add_player -> :players_set

  :players_set
   - Can :position_islands
   - Can :set_islands -> :player1_turn

  :player1_turn
  """
  alias __MODULE__

  defstruct state: :initialized,
            player1: :islands_not_set,
            player2: :islands_not_set

  @spec new() :: %Rules{state: :initialized}
  def new do
    %Rules{}
  end

  @spec check(%Rules{state: :initialized}, :add_player) :: {:ok, %Rules{state: :players_set}}
  def check(%Rules{state: :initialized} = rules, :add_player) do
    {:ok, %Rules{rules | state: :players_set}}
  end

  @spec check(%Rules{state: :players_set}, {:position_islands, :player1 | :player2}) ::
          {:ok, %Rules{}} | :error
  def check(%Rules{state: :players_set} = rules, {:position_islands, player}) do
    case Map.fetch!(rules, player) do
      :islands_set -> :error
      :islands_not_set -> {:ok, rules}
    end
  end

  @spec check(%Rules{state: :players_set}, {:set_islands, :player1 | :player2}) ::
          {:ok, %Rules{state: :players_set}} | {:ok, %Rules{state: :player1_turn}}
  def check(%Rules{state: :players_set} = rules, {:set_islands, player}) do
    rules = Map.put(rules, player, :islands_set)

    case both_players_islands_set?(rules) do
      true -> {:ok, %Rules{rules | state: :player1_turn}}
      false -> {:ok, rules}
    end
  end

  @spec check(term(), term()) :: :error
  def check(_state, _action) do
    :error
  end

  defp both_players_islands_set?(rules) do
    rules.player1 == :islands_set && rules.player2 == :islands_set
  end
end
