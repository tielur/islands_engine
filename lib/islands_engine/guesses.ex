defmodule IslandsEngine.Guesses do
  @moduledoc """
  Gusses struct
  """
  alias IslandsEngine.{
    Coordinate,
    Guesses
  }

  @enforce_keys [:hits, :misses]
  defstruct [:hits, :misses]

  @spec new() :: %Guesses{}
  def new do
    %Guesses{hits: MapSet.new(), misses: MapSet.new()}
  end

  @spec add(%Guesses{}, atom(), %Coordinate{}) :: %Guesses{}
  def add(%Guesses{} = guesses, :hit, %Coordinate{} = coordinate) do
    update_in(guesses.hits, &MapSet.put(&1, coordinate))
  end

  def add(%Guesses{} = guesses, :miss, %Coordinate{} = coordinate) do
    update_in(guesses.misses, &MapSet.put(&1, coordinate))
  end
end
