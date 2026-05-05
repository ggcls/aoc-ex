defmodule Mix.Tasks.NewDay do
  use Mix.Task

  alias AocEx.DayUtils

  @shortdoc "Creates a new Advent of Code day from the template"

  @default_year 2025
  @source_template Path.join(["priv", "templates", "aoc_day", "day_n.ex"])
  @test_template Path.join(["priv", "templates", "aoc_day", "day_n_test.exs"])

  @impl Mix.Task
  def run(args) do
    with {:ok, year, day} <- parse_args(args),
         {:ok, target_dir} <- create_day(year, day) do
      Mix.shell().info("Created #{target_dir}")
    else
      {:error, message} ->
        Mix.raise("#{message}\n\nUsage: mix new_day [YEAR] DAY")
    end
  end

  defp parse_args([year, day]) do
    with {:ok, year_number} <- DayUtils.parse_year(year),
         {:ok, day_number} <- DayUtils.parse_day(day) do
      {:ok, year_number, day_number}
    end
  end

  defp parse_args([day]) do
    case DayUtils.parse_day(day) do
      {:ok, day_number} -> {:ok, @default_year, day_number}
      {:error, message} -> {:error, message}
    end
  end

  defp parse_args(_args), do: {:error, "Expected DAY or YEAR DAY arguments."}

  defp create_day(year, day) do
    padded_day = DayUtils.format_day(day)
    module_name = "Day#{padded_day}"
    year_module_name = "Year#{year}"
    source_dir = DayUtils.source_dir(year, day)
    test_dir = DayUtils.test_dir(year, day)
    source_target = DayUtils.source_path(year, day)
    test_target = DayUtils.test_path(year, day)
    input_target = Path.join(source_dir, "input.txt")

    cond do
      not File.exists?(@source_template) ->
        {:error, "Source template #{@source_template} does not exist."}

      not File.exists?(@test_template) ->
        {:error, "Test template #{@test_template} does not exist."}

      File.exists?(source_dir) ->
        {:error, "Source directory #{source_dir} already exists."}

      File.exists?(test_dir) ->
        {:error, "Test directory #{test_dir} already exists."}

      true ->
        write_from_template!(
          @source_template,
          source_target,
          year,
          year_module_name,
          module_name,
          day
        )

        write_from_template!(
          @test_template,
          test_target,
          year,
          year_module_name,
          module_name,
          day
        )

        File.touch!(input_target)

        {:ok, source_dir}
    end
  end

  defp write_from_template!(template, target, year, year_module_name, module_name, day) do
    target
    |> Path.dirname()
    |> File.mkdir_p!()

    template
    |> File.read!()
    |> String.replace("YearYEAR", year_module_name)
    |> String.replace("@year YEAR", "@year #{year}")
    |> String.replace("DayN", module_name)
    |> String.replace(":day_number", Integer.to_string(day))
    |> then(&File.write!(target, &1))
  end
end
