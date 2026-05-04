defmodule Main do
  @input Path.join(__DIR__, "input.txt")
         |> File.read!()
         |> String.trim_trailing("\n")

  if @input == "" do
    raise "empty input.txt file"
  end

  def main(args) do
    {opts, _rest, _invalid} =
      OptionParser.parse(args,
        switches: [part: :integer],
        aliases: [p: :part]
      )

    part = Keyword.get(opts, :part, 1)

    IO.puts("Running part #{part}")

    output =
      case part do
        1 -> part1(@input)
        2 -> part2(@input)
        _ -> raise "part must be 1 or 2"
      end

    IO.puts("Output: #{output}")
  end

  def rotate(position, <<direction::binary-size(1), distance::binary>>) do
    distance = String.to_integer(distance)

    case direction do
      # Move right: increase position
      "R" ->
        rem(position + distance, 100)

      # Move left: decrease position
      "L" ->
        Integer.mod(position - distance, 100)
    end
  end

  def part1(input) do
    input
    |> parse_input()
    # We keep track of:
    # - current dial position
    # - how many times we hit 0
    |> Enum.reduce({50, 0}, fn rotation, {position, count} ->
      new_position = rotate(position, rotation)

      # If we land on 0, increment counter
      new_count =
        if new_position == 0 do
          count + 1
        else
          count
        end

      {new_position, new_count}
    end)
    |> elem(1)
  end

  def part2(input) do
    input
    |> parse_input()
    |> length()
  end

  def parse_input(input) do
    input
    |> String.replace("\r", "")
    |> String.trim()
    |> String.split("\n")
  end
end

Main.main(System.argv())
