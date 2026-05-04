ExUnit.start()

Code.require_file("main.exs", __DIR__)

defmodule MainTest do
  use ExUnit.Case

  @example "L68
L30
R48
L5
R60
L55
L1
L99
R14
L82"

  test "part1" do
    assert Main.part1(@example) == 3
  end

  test "part2" do
    assert Main.part2(@example) == 0
  end
end
