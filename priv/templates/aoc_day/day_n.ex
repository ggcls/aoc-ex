defmodule AocEx.YearYEAR.DayN do
  alias AocEx.InputUtils
  alias AocEx.SolutionRunner

  @year YEAR
  @day :day_number

  def main(args), do: SolutionRunner.run(__MODULE__, @year, @day, args)

  def part1(input) do
    input
    |> parse_input()
    |> length()
  end

  def part2(input) do
    input
    |> parse_input()
    |> length()
  end

  def parse_input(input), do: InputUtils.lines(input)
end
