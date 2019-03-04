defmodule IslandsEngine.BoardTest do
  use ExUnit.Case
  doctest IslandsEngine.Board

  alias IslandsEngine.{
    Board,
    Coordinate,
    Island
  }

  describe "new/0" do
    test "returns an empty map" do
      assert %{} = Board.new()
    end
  end

  describe "position_island/3" do
    test "when the island doesn't overlap it adds the island under the key" do
      board = Board.new()
      {:ok, coordinate} = Coordinate.new(1, 1)
      {:ok, island} = Island.new(:square, coordinate)
      assert %{square: island} = Board.position_island(board, :square, island)
    end

    test "when the island does overlap it returns error" do
      board = Board.new()
      {:ok, coordinate} = Coordinate.new(1, 1)
      {:ok, island} = Island.new(:square, coordinate)
      board = Board.position_island(board, :square, island)

      {:ok, new_coordinate} = Coordinate.new(1, 1)
      {:ok, new_island} = Island.new(:dot, new_coordinate)
      assert {:error, :overlapping_island} = Board.position_island(board, :dot, new_island)
    end
  end

  describe "all_islands_positioned?" do
  end
end
