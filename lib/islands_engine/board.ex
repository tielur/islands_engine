defmodule IslandsEngine.Board do
  @moduledoc """
  Board struct
  """
  alias IslandsEngine.Island

  def new, do: %{}

  @spec position_island(map(), term(), %Island{}) :: map() | {:error, :overlapping_island}
  def position_island(board, key, %Island{} = island) do
    case overlaps_existing_island?(board, key, island) do
      true -> {:error, :overlapping_island}
      false -> Map.put(board, key, island)
    end
  end

  @spec all_islands_positioned?(map()) :: boolean()
  def all_islands_positioned?(board) do
    Enum.all?(Island.types(), &Map.has_key?(board, &1))
  end
  end
end
