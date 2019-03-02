defmodule IslandsEngine.CoordinateTest do
  use ExUnit.Case
  doctest IslandsEngine.Coordinate

  alias IslandsEngine.Coordinate

  describe "new/2" do
    test "when given a correct row and col it returns a Coordinate for that row and col" do
      assert {:ok, %Coordinate{row: 1, col: 1}} = Coordinate.new(1, 1)
    end

    test "when given an invalid row (outside of 1..10) it returns an error" do
      assert {:error, :invalid_coordinate} = Coordinate.new(11, 1)
    end

    test "when given an invalid col (outside of 1..10) it returns an error" do
      assert {:error, :invalid_coordinate} = Coordinate.new(1, 11)
    end
  end
end
