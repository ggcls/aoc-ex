defmodule AocEx.Year2025.Day02 do
  alias AocEx.InputUtils
  alias AocEx.SolutionRunner

  @year 2025
  @day 2

  def main(args), do: SolutionRunner.run(__MODULE__, @year, @day, args)

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

  def part2(input) do
    ranges = parse_input(input)

    # Part two accepts the same pattern repeated any number of times, as long
    # as it is repeated at least twice.
    ranges
    |> max_range_id()
    |> ids_repeated_at_least_twice_up_to()
    |> Enum.filter(&inside_any_range?(&1, ranges))
    |> Enum.sum()
  end

  def parse_input(input) do
    input
    |> InputUtils.normalize()
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
    |> Enum.flat_map(&ids_with_pattern_length(&1, 2, max_id))
  end

  defp ids_repeated_at_least_twice_up_to(max_id) when max_id < 11, do: []

  defp ids_repeated_at_least_twice_up_to(max_id) do
    # We only need to generate invalid IDs up to the largest range endpoint.
    max_digits =
      max_id
      |> Integer.to_string()
      |> String.length()

    # The repeated pattern must appear at least twice, so its length can be at
    # most half of the final ID length.
    1..div(max_digits, 2)
    |> Enum.flat_map(fn pattern_length ->
      max_repetitions = div(max_digits, pattern_length)

      2..max_repetitions
      |> Enum.flat_map(fn repetitions ->
        ids_with_pattern_length(pattern_length, repetitions, max_id)
      end)
    end)
    # Some IDs match the rule in multiple ways, like 1111 = 1x4 and 11x2.
    |> Enum.uniq()
  end

  defp ids_with_pattern_length(pattern_length, repetitions, max_id) do
    scale = pow10(pattern_length)
    # Prefixes cannot start with zero because product IDs have no leading zeroes.
    first_prefix = div(scale, 10)
    last_prefix = scale - 1

    first_prefix..last_prefix
    |> Stream.map(&repeat_digits(&1, repetitions))
    |> Enum.take_while(&(&1 <= max_id))
  end

  defp repeat_digits(prefix, repetitions) do
    # Example: repeating 123 three times gives 123123123.
    digits = Integer.to_string(prefix)

    digits
    |> String.duplicate(repetitions)
    |> String.to_integer()
  end

  defp inside_any_range?(id, ranges) do
    Enum.any?(ranges, fn {first, last} -> id >= first and id <= last end)
  end

  defp pow10(0), do: 1

  defp pow10(power) do
    Enum.reduce(1..power, 1, fn _step, total -> total * 10 end)
  end
end
