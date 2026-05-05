defmodule AocEx.Year2025.Day02Test do
  use ExUnit.Case

  alias AocEx.Year2025.Day02

  @example "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,
1698522-1698528,446443-446449,38593856-38593862,565653-565659,
824824821-824824827,2121212118-2121212124"

  test "part1" do
    assert Day02.part1(@example) == 1_227_775_554
  end

  test "part2" do
    assert Day02.part2(@example) == 4_174_379_265
  end
end
