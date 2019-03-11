defmodule IslandsEngine.RulesTest do
  use ExUnit.Case
  doctest IslandsEngine.Rules

  alias IslandsEngine.Rules

  describe "new/0" do
    test "returns a new Rules struct" do
      assert %Rules{} = Rules.new()
    end

    test "default state is :initialized" do
      rules = Rules.new()
      assert rules.state == :initialized
    end

    test "default player1 state is :islands_not_set" do
      rules = Rules.new()
      assert rules.player1 == :islands_not_set
    end

    test "default player2 state is :islands_not_set" do
      rules = Rules.new()
      assert rules.player2 == :islands_not_set
    end
  end

  describe "check/2 when state is :initialized" do
    setup do
      rules = Rules.new()
      {:ok, rules: rules}
    end

    test "when in the initialized state, we can add a player", %{rules: rules} do
      assert {:ok, %Rules{state: :players_set}} = Rules.check(rules, :add_player)
    end
  end

  describe "check/2 when state is :players_set" do
    setup do
      rules = Rules.new()
      rules = %{rules | state: :players_set}

      {:ok, rules: rules}
    end

    test "allows :position_islands", %{rules: rules} do
      assert {:ok, rules} = Rules.check(rules, {:position_islands, :player1})
      assert {:ok, rules} = Rules.check(rules, {:position_islands, :player2})
    end

    test "player1 can set their islands", %{rules: rules} do
      assert {:ok, rules} = Rules.check(rules, {:set_islands, :player1})
    end

    test "player2 can set their islands", %{rules: rules} do
      assert {:ok, rules} = Rules.check(rules, {:set_islands, :player2})
    end

    test "player1 can set their islands multiple times", %{rules: rules} do
      assert {:ok, rules} = Rules.check(rules, {:set_islands, :player1})
      assert {:ok, rules} = Rules.check(rules, {:set_islands, :player1})
    end

    test "player2 can set their islands multiple times", %{rules: rules} do
      assert {:ok, rules} = Rules.check(rules, {:set_islands, :player2})
      assert {:ok, rules} = Rules.check(rules, {:set_islands, :player2})
    end

    test "once a player sets their islands, they can't position them anymore but the other player can",
         %{rules: rules} do
      assert {:ok, rules} = Rules.check(rules, {:set_islands, :player1})
      assert :error = Rules.check(rules, {:position_islands, :player1})
      assert {:ok, rules} = Rules.check(rules, {:position_islands, :player2})
    end

    test "when both players set their islands it should move the state to :player1_turn", %{
      rules: rules
    } do
      assert {:ok, rules} = Rules.check(rules, {:set_islands, :player1})
      assert {:ok, rules} = Rules.check(rules, {:set_islands, :player2})
      assert rules.state == :player1_turn
    end
  end
end
