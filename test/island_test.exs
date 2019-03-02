defmodule IslandsEngine.IslandTest do
  use ExUnit.Case
  doctest IslandsEngine.Island

  alias IslandsEngine.{
    Coordinate,
    Island
  }

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
