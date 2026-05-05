ExUnit.start()

Code.require_file("main.exs", __DIR__)

defmodule MainTest do
  use ExUnit.Case

  @example "987654321111111
811111111111119
234234234234278
818181911112111"

  test "part1" do
    assert Main.part1(@example) == 357
  end

  test "part2" do
    assert Main.part2(@example) == 3_121_910_778_619
  end
end
