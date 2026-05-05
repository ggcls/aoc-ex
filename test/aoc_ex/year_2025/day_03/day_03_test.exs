defmodule AocEx.Year2025.Day03Test do
  use ExUnit.Case

  alias AocEx.Year2025.Day03

  @example "987654321111111
811111111111119
234234234234278
818181911112111"

  test "part1" do
    assert Day03.part1(@example) == 357
  end

  test "part2" do
    assert Day03.part2(@example) == 3_121_910_778_619
  end
end
