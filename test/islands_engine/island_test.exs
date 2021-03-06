defmodule IslandsEngine.IslandTest do
  use ExUnit.Case
  doctest IslandsEngine.Island

  alias IslandsEngine.{
    Coordinate,
    Island
  }

  describe "new/2" do
    test "when given a correct type and coordinate it returns {:ok, %Island{}}" do
      {:ok, coordinate} = Coordinate.new(4, 6)
      assert {:ok, %Island{}} = Island.new(:l_shape, coordinate)
    end

    test "when given a wrong type it returns an error" do
      {:ok, coordinate} = Coordinate.new(1, 1)
      assert {:error, :invalid_island_type} = Island.new(:wrong_type, coordinate)
    end

    test "when given an invalid coordinate it returns an error" do
      {:ok, coordinate} = Coordinate.new(10, 10)
      assert {:error, :invalid_coordinate} = Island.new(:l_shape, coordinate)
    end
  end

  describe "overlaps?/2" do
    test "when two shapes overlap it returns true" do
      {:ok, square_coordinate} = Coordinate.new(1, 1)
      {:ok, square} = Island.new(:square, square_coordinate)

      {:ok, dot_coordinate} = Coordinate.new(1, 2)
      {:ok, dot} = Island.new(:dot, dot_coordinate)

      assert true = Island.overlaps?(square, dot)
    end

    test "when two shapes don't overlap it returns false" do
      {:ok, square_coordinate} = Coordinate.new(1, 1)
      {:ok, square} = Island.new(:square, square_coordinate)

      {:ok, l_shape_coordinate} = Coordinate.new(5, 5)
      {:ok, l_shape} = Island.new(:l_shape, l_shape_coordinate)

      assert false == Island.overlaps?(square, l_shape)
    end
  end

  describe "guess/2" do
    test "when the guess wasn't correct it returns :miss" do
      {:ok, coordinate} = Coordinate.new(1, 1)
      {:ok, island} = Island.new(:dot, coordinate)

      {:ok, guess_coordinate} = Coordinate.new(5, 5)
      assert :miss = Island.guess(island, guess_coordinate)
    end

    test "when the guess was correct it returns updated hit_coordinates for island" do
      {:ok, coordinate} = Coordinate.new(1, 1)
      {:ok, island} = Island.new(:dot, coordinate)

      assert {:hit, island} = Island.guess(island, coordinate)
    end
  end

  describe "forested?/1" do
    test "when the coordinates match the hit_coordinates it returns true" do
      {:ok, coordinate} = Coordinate.new(1, 1)
      {:ok, island} = Island.new(:dot, coordinate)
      {:hit, island} = Island.guess(island, coordinate)

      assert Island.forested?(island)
    end

    test "when the coordinates don't match the hit_coordinates it returns false" do
      {:ok, coordinate} = Coordinate.new(1, 1)
      {:ok, island} = Island.new(:dot, coordinate)

      assert false == Island.forested?(island)
    end
  end
end
