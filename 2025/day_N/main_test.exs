ExUnit.start()

Code.require_file("main.exs", __DIR__)

defmodule MainTest do
  use ExUnit.Case

  @example ""

  test "part1" do
    assert Main.part1(@example) == 0
  end

  test "part2" do
    assert Main.part2(@example) == 0
  end
end
