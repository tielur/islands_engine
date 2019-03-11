defmodule IslandsEngine.GuessesTest do
  use ExUnit.Case
  doctest IslandsEngine.Guesses

  alias IslandsEngine.{
    Coordinate,
    Guesses
  }

  describe "new/0" do
    test "returns a Guesses struct with empty MapSets" do
      assert %Guesses{hits: %MapSet{}, misses: %MapSet{}} = Guesses.new()
    end
  end

  describe "add/3" do
    setup do
      {:ok, guesses: Guesses.new()}
    end

    test "adds to misses when given :miss", %{guesses: guesses} do
      {:ok, coordinate} = Coordinate.new(1, 2)
      guesses = Guesses.add(guesses, :miss, coordinate)
      assert MapSet.member?(guesses.misses, coordinate)
    end

    test "adds to hits when given :hit", %{guesses: guesses} do
      {:ok, coordinate} = Coordinate.new(1, 2)
      guesses = Guesses.add(guesses, :hit, coordinate)
      assert MapSet.member?(guesses.hits, coordinate)
    end

    test "raises when given anything else", %{guesses: guesses} do
      {:ok, coordinate} = Coordinate.new(1, 2)

      assert_raise FunctionClauseError, fn ->
        Guesses.add(guesses, :something_else, coordinate)
      end
    end
  end
end
