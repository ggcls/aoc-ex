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
    ranges = parse_input(input)

    # Generate every ID that can match the invalid pattern, then keep the ones
    # that appear in one of the checked product ID ranges.
    ranges
    |> max_range_id()
    |> invalid_ids_up_to()
    |> Enum.filter(&inside_any_range?(&1, ranges))
    |> Enum.sum()
  end

  def part2(_input) do
    0
  end

  def parse_input(input) do
    input
    |> String.replace("\r", "")
    |> String.trim()
    |> String.split(",", trim: true)
    |> Enum.map(fn range ->
      [first, last] =
        range
        |> String.trim()
        |> String.split("-", parts: 2)

      {String.to_integer(first), String.to_integer(last)}
    end)
  end

  defp max_range_id(ranges) do
    ranges
    |> Enum.map(&elem(&1, 1))
    |> Enum.max()
  end

  defp invalid_ids_up_to(max_id) when max_id < 11, do: []

  defp invalid_ids_up_to(max_id) do
    # Invalid IDs have an even number of digits: some prefix repeated twice.
    # The longest possible prefix is therefore half the length of the max ID.
    max_half_length =
      max_id
      |> Integer.to_string()
      |> String.length()
      |> div(2)

    1..max_half_length
    |> Enum.flat_map(&invalid_ids_with_half_length(&1, max_id))
  end

  defp invalid_ids_with_half_length(half_length, max_id) do
    scale = pow10(half_length)
    # Prefixes cannot start with zero because product IDs have no leading zeroes.
    first_prefix = div(scale, 10)
    last_prefix = scale - 1

    first_prefix..last_prefix
    |> Stream.map(&repeat_digits_twice/1)
    |> Enum.take_while(&(&1 <= max_id))
  end

  defp repeat_digits_twice(prefix) do
    # Example: 123 becomes 123123.
    digits = Integer.to_string(prefix)
    String.to_integer(digits <> digits)
  end

  defp inside_any_range?(id, ranges) do
    Enum.any?(ranges, fn {first, last} -> id >= first and id <= last end)
  end

  defp pow10(0), do: 1

  defp pow10(power) do
    Enum.reduce(1..power, 1, fn _step, total -> total * 10 end)
  end
end

unless Process.whereis(ExUnit.Server) do
  Main.main(System.argv())
end
