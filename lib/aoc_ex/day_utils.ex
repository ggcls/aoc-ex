defmodule AocEx.DayUtils do
  def parse_year(year) do
    case Integer.parse(to_string(year)) do
      {year_number, ""} -> {:ok, year_number}
      _invalid -> {:error, "YEAR must be a number."}
    end
  end

  def parse_day(day) do
    case Integer.parse(to_string(day)) do
      {day_number, ""} when day_number in 1..25 -> {:ok, day_number}
      _invalid -> {:error, "DAY must be a number from 1 to 25."}
    end
  end

  def format_day(day) when is_integer(day) do
    day
    |> Integer.to_string()
    |> String.pad_leading(2, "0")
  end

  def format_day(day), do: day |> to_string() |> String.to_integer() |> format_day()

  def solution_module(year, day) do
    Module.concat([AocEx, "Year#{year}", "Day#{format_day(day)}"])
  end

  def source_dir(year, day) do
    Path.join(["lib", "aoc_ex", "year_#{year}", "day_#{format_day(day)}"])
  end

  def source_path(year, day) do
    Path.join(source_dir(year, day), "day_#{format_day(day)}.ex")
  end

  def input_path(year, day) do
    Path.join([File.cwd!(), source_dir(year, day), "input.txt"])
  end

  def test_dir(year, day) do
    Path.join(["test", "aoc_ex", "year_#{year}", "day_#{format_day(day)}"])
  end

  def test_path(year, day) do
    Path.join(test_dir(year, day), "day_#{format_day(day)}_test.exs")
  end
end
