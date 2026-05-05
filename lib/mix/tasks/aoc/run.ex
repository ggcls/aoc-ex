defmodule Mix.Tasks.Aoc.Run do
  use Mix.Task

  alias AocEx.DayUtils

  @shortdoc "Runs one Advent of Code day"

  @impl Mix.Task
  def run(args) do
    with {:ok, module, source_path, solution_args} <- parse_target(args),
         :ok <- ensure_file_exists(source_path),
         :ok <- ensure_module_loaded(module) do
      module.main(solution_args)
    else
      {:error, message} ->
        Mix.raise("#{message}\n\nUsage: mix aoc.run YEAR DAY [--part PART]")
    end
  end

  defp parse_target([year, day | solution_args]) do
    with {:ok, year_number} <- DayUtils.parse_year(year),
         {:ok, day_number} <- DayUtils.parse_day(day) do
      {:ok, DayUtils.solution_module(year_number, day_number),
       DayUtils.source_path(year_number, day_number), solution_args}
    end
  end

  defp parse_target(_args), do: {:error, "Expected YEAR and DAY arguments."}

  defp ensure_file_exists(path) do
    if File.exists?(path) do
      :ok
    else
      {:error, "Solution file #{path} does not exist."}
    end
  end

  defp ensure_module_loaded(module) do
    if Code.ensure_loaded?(module) do
      :ok
    else
      {:error, "Solution module #{inspect(module)} does not exist."}
    end
  end
end
