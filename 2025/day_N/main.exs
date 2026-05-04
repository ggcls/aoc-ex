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

  def parse_input(input) do
    input
    |> String.replace("\r", "")
    |> String.trim()
    |> String.split("\n")
  end
end

Main.main(System.argv())
