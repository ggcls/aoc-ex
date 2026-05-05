defmodule Mix.Tasks.Aoc.Test do
  use Mix.Task

  alias AocEx.DayUtils

  @shortdoc "Runs tests for one Advent of Code day"

  @impl Mix.Task
  def run(args) do
    with {:ok, test_path, test_args} <- parse_target(args),
         :ok <- ensure_file_exists(test_path) do
      Mix.Task.run("test", [test_path | test_args])
    else
      {:error, message} ->
        Mix.raise("#{message}\n\nUsage: mix aoc.test YEAR DAY [mix test options]")
    end
  end

  defp parse_target([year, day | test_args]) do
    with {:ok, year_number} <- DayUtils.parse_year(year),
         {:ok, day_number} <- DayUtils.parse_day(day) do
      {:ok, DayUtils.test_path(year_number, day_number), test_args}
    end
  end

  defp parse_target(_args), do: {:error, "Expected YEAR and DAY arguments."}

  defp ensure_file_exists(path) do
    if File.exists?(path) do
      :ok
    else
      {:error, "Test file #{path} does not exist."}
    end
  end
end
