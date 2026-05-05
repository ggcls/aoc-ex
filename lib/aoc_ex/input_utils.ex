defmodule AocEx.InputUtils do
  alias AocEx.DayUtils

  def read!(year, day) do
    path = DayUtils.input_path(year, day)

    input =
      path
      |> File.read!()
      |> String.trim_trailing("\n")

    if input == "" do
      raise "empty #{path} file"
    end

    input
  end

  def lines(input) do
    input
    |> normalize()
    |> String.split("\n", trim: true)
  end

  def normalize(input) do
    input
    |> String.replace("\r", "")
    |> String.trim()
  end

  defdelegate input_path(year, day), to: DayUtils
  defdelegate format_day(day), to: DayUtils
end
