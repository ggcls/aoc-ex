defmodule NewDay do
  @year "2025"
  @template_day "day_N"
  @files_to_copy ["main.exs", "main_test.exs"]

  def main(args) do
    with {:ok, day} <- parse_day(args),
         {:ok, target_dir} <- create_day(day) do
      IO.puts("Created #{target_dir}")
    else
      {:error, message} ->
        IO.puts(:stderr, message)
        IO.puts(:stderr, "Usage: elixir new_day.exs DAY")
        System.halt(1)
    end
  end

  defp parse_day([day]) do
    case Integer.parse(day) do
      {number, ""} when number in 1..25 ->
        {:ok, number}

      _invalid ->
        {:error, "DAY must be a number from 1 to 25."}
    end
  end

  defp parse_day(_args), do: {:error, "Expected exactly one DAY argument."}

  defp create_day(day) do
    source_dir = Path.join(@year, @template_day)
    target_dir = Path.join(@year, "day_#{pad_day(day)}")

    cond do
      not File.dir?(source_dir) ->
        {:error, "Template directory #{source_dir} does not exist."}

      File.exists?(target_dir) ->
        {:error, "Target directory #{target_dir} already exists."}

      true ->
        File.mkdir_p!(target_dir)

        Enum.each(@files_to_copy, fn file ->
          File.cp!(Path.join(source_dir, file), Path.join(target_dir, file))
        end)

        File.touch!(Path.join(target_dir, "input.txt"))

        {:ok, target_dir}
    end
  end

  defp pad_day(day) do
    day
    |> Integer.to_string()
    |> String.pad_leading(2, "0")
  end
end

NewDay.main(System.argv())
