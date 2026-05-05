defmodule AocEx.Year2025.Day04 do
  alias AocEx.InputUtils
  alias AocEx.SolutionRunner

  @year 2025
  @day 4

  def main(args), do: SolutionRunner.run(__MODULE__, @year, @day, args)

  def part1(input) do
    rolls =
      input
      |> parse_input()

    Enum.count(rolls, &(adjacent_roll_count(&1, rolls) < 4))
  end

  def part2(input) do
    input
    |> parse_input()
    |> length()
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
