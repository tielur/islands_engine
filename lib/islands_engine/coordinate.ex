defmodule IslandsEngine.Coordinate do
  @moduledoc """
  Coordinate struct
  """
  alias __MODULE__

  @enforce_keys [:row, :col]
  defstruct [:row, :col]

  @board_range 1..10

  @spec new(integer(), integer()) :: {:ok, %Coordinate{}} | {:error, :invalid_coordinate}
  def new(row, col) when row in @board_range and col in @board_range do
    {:ok, %Coordinate{row: row, col: col}}
  end

  def new(_row, _col) do
    {:error, :invalid_coordinate}
  end
end
