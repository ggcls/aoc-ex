defmodule AocEx.Year2025.Day04 do
  alias AocEx.InputUtils
  alias AocEx.SolutionRunner

  @year 2025
  @day 4

  def main(args), do: SolutionRunner.run(__MODULE__, @year, @day, args)

  def part1(input) do
    input
    |> parse_input()
    |> accessible_rolls()
    |> MapSet.size()
  end

  def part2(input) do
    input
    |> parse_input()
    |> removable_roll_count()
  end

  def parse_input(input) do
    input
    |> InputUtils.lines()
    |> Enum.with_index()
    |> Enum.reduce(MapSet.new(), fn {line, row}, rolls ->
      line
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.reduce(rolls, fn
        {"@", col}, rolls -> MapSet.put(rolls, {row, col})
        {_space, _col}, rolls -> rolls
      end)
    end)
  end

  def removable_roll_count(rolls), do: removable_roll_count(rolls, 0)

  defp removable_roll_count(rolls, removed_count) do
    removable_rolls = accessible_rolls(rolls)

    if MapSet.size(removable_rolls) == 0 do
      removed_count
    else
      rolls
      |> MapSet.difference(removable_rolls)
      |> removable_roll_count(removed_count + MapSet.size(removable_rolls))
    end
  end

  defp accessible_rolls(rolls) do
    rolls
    |> Enum.filter(&(adjacent_roll_count(&1, rolls) < 4))
    |> MapSet.new()
  end

  defp adjacent_roll_count({row, col}, rolls) do
    Enum.count(adjacent_positions(row, col), &MapSet.member?(rolls, &1))
  end

  defp adjacent_positions(row, col) do
    for row_offset <- -1..1,
        col_offset <- -1..1,
        {row_offset, col_offset} != {0, 0} do
      {row + row_offset, col + col_offset}
    end
  end
end
