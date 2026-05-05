defmodule AocEx.SolutionRunner do
  alias AocEx.InputUtils

  def run(solution_module, year, day, args) do
    {opts, _rest, _invalid} =
      OptionParser.parse(args,
        switches: [part: :integer],
        aliases: [p: :part]
      )

    part = Keyword.get(opts, :part, 1)

    IO.puts("Running part #{part}")

    input = InputUtils.read!(year, day)

    output =
      Timer.measure(
        fn -> run_part(solution_module, part, input) end,
        "part #{part}"
      )

    IO.puts("Output: #{output}")
  end

  defp run_part(solution_module, 1, input), do: solution_module.part1(input)
  defp run_part(solution_module, 2, input), do: solution_module.part2(input)
  defp run_part(_solution_module, _part, _input), do: raise("part must be 1 or 2")
end
