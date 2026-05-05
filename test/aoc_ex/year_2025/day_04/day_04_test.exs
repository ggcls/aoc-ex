defmodule AocEx.Year2025.Day04Test do
  use ExUnit.Case

  alias AocEx.Year2025.Day04

  @example "..@@.@@@@.
@@@.@.@.@@
@@@@@.@.@@
@.@@@@..@.
@@.@@@@.@@
.@@@@@@@.@
.@.@.@.@@@
@.@@@.@@@@
.@@@@@@@@.
@.@.@@@.@."

  test "part1" do
    assert Day04.part1(@example) == 13
  end

  test "part2" do
    assert Day04.part2(@example) == 0
  end
end
