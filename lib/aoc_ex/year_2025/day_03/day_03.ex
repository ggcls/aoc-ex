defmodule AocEx.Year2025.Day03 do
  alias AocEx.InputUtils
  alias AocEx.SolutionRunner

  @year 2025
  @day 3

  def main(args), do: SolutionRunner.run(__MODULE__, @year, @day, args)

  def part1(input) do
    input
    |> parse_input()
    |> Enum.map(&find_voltage(&1, 2))
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> parse_input()
    |> Enum.map(&find_voltage(&1, 12))
    |> Enum.sum()
  end

  def parse_input(input), do: InputUtils.lines(input)

  def find_voltage(bank, num_values) do
    String.to_charlist(bank)
    |> pick_best_digits(num_values, [])
    |> List.to_string()
    |> String.to_integer()
  end

  defp pick_best_digits(_digits, 0, picked), do: Enum.reverse(picked)

  defp pick_best_digits(digits, remaining, picked) do
    # Choose the largest next digit while leaving enough batteries to complete
    # the requested joltage value without rearranging the bank.
    {window, rest} = Enum.split(digits, length(digits) - remaining + 1)
    {_skipped, [chosen | remaining_window]} = Enum.split_while(window, &(&1 != Enum.max(window)))

    pick_best_digits(remaining_window ++ rest, remaining - 1, [chosen | picked])
  end
end
