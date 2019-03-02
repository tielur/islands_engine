defmodule IslandsEngine.GuessesTest do
  use ExUnit.Case
  doctest IslandsEngine.Guesses

  alias IslandsEngine.Guesses

  describe "new/0" do
    test "returns a Guesses struct with empty MapSets" do
      assert %Guesses{hits: %MapSet{}, misses: %MapSet{}} = Guesses.new()
    end
  end
end
