defmodule Main do
  @input_path Path.join(__DIR__, "input.txt")

  def main(args) do
    {opts, _rest, _invalid} =
      OptionParser.parse(args,
        switches: [part: :integer],
        aliases: [p: :part]
      )

    part = Keyword.get(opts, :part, 1)

    IO.puts("Running part #{part}")

    input = read_input!()

    output =
      case part do
        1 -> part1(input)
        2 -> part2(input)
        _ -> raise "part must be 1 or 2"
      end

    IO.puts("Output: #{output}")
  end

  def read_input! do
    input =
      @input_path
      |> File.read!()
      |> String.trim_trailing("\n")

    if input == "" do
      raise "empty input.txt file"
    end

    input
  end

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

  def parse_input(input) do
    input
    |> String.replace("\r", "")
    |> String.trim()
    |> String.split("\n", trim: true)
  end

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

unless Process.whereis(ExUnit.Server) do
  Main.main(System.argv())
end
