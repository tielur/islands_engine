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

  describe "all_islands_positioned?/1" do
    test "when all of the islands have been placed it returns true" do
      board = Board.new()
      {:ok, dot_coordinate} = Coordinate.new(1, 1)
      {:ok, dot_island} = Island.new(:dot, dot_coordinate)

      {:ok, atoll_coordinate} = Coordinate.new(2, 1)
      {:ok, atoll_island} = Island.new(:atoll, atoll_coordinate)

      {:ok, l_shape_coordinate} = Coordinate.new(4, 5)
      {:ok, l_shape_island} = Island.new(:l_shape, l_shape_coordinate)

      {:ok, s_shape_coordinate} = Coordinate.new(6, 1)
      {:ok, s_shape_island} = Island.new(:s_shape, s_shape_coordinate)

      {:ok, square_coordinate} = Coordinate.new(8, 1)
      {:ok, square_island} = Island.new(:square, square_coordinate)

      board = Board.position_island(board, :dot, dot_island)
      board = Board.position_island(board, :atoll, atoll_island)
      board = Board.position_island(board, :l_shape, l_shape_island)
      board = Board.position_island(board, :s_shape, s_shape_island)
      board = Board.position_island(board, :square, square_island)

      assert Board.all_islands_positioned?(board)
    end

    test "when all of the islands have not been placed it returns false" do
      board = Board.new()
      refute Board.all_islands_positioned?(board)
    end
  end

  describe "guess/2" do
    setup do
      board = Board.new()
      {:ok, square_coordinate} = Coordinate.new(1, 1)
      {:ok, square_island} = Island.new(:square, square_coordinate)
      board = Board.position_island(board, :square, square_island)
      {:ok, dot_coordinate} = Coordinate.new(3, 3)
      {:ok, dot_island} = Island.new(:dot, dot_coordinate)
      board = Board.position_island(board, :dot, dot_island)

      {:ok, board: board, square_island: square_island}
    end

    test "when a guess misses", %{board: board} do
      {:ok, guess_coordinate} = Coordinate.new(10, 10)
      assert {:miss, :none, :no_win, board} = Board.guess(board, guess_coordinate)
    end

    test "when a guess hits", %{board: board} do
      {:ok, guess_coordinate} = Coordinate.new(1, 1)
      assert {:hit, :none, :no_win, board} = Board.guess(board, guess_coordinate)
    end

    test "when a guess hits and it's a win", %{square_island: square_island, board: board} do
      # make the squares hit_coordinates the same as it's coordinates
      # to simulate that it's been forested
      square_island = %{square_island | hit_coordinates: square_island.coordinates}
      board = Board.position_island(board, :square, square_island)

      {:ok, win_coordinate_guess} = Coordinate.new(3, 3)
      {:hit, :dot, :win, _board} = Board.guess(board, win_coordinate_guess)
    end
  end
end
