defmodule GigasecondTest do
  use ExUnit.Case

  # @tag :pending
  test "from 4/25/2011" do
    assert Gigasecond.from({{2011, 4, 25}, {0, 0, 0}}) == {{2043, 1, 1}, {1, 46, 40}}
  end

  # @tag :pending
  test "from 6/13/1977" do
    assert Gigasecond.from({{1977, 6, 13}, {0, 0, 0}}) == {{2009, 2, 19}, {1, 46, 40}}
  end

  # @tag :pending
  test "from 7/19/1959" do
    assert Gigasecond.from({{1959, 7, 19}, {0, 0, 0}}) == {{1991, 3, 27}, {1, 46, 40}}
  end

  # @tag :pending
  test "yourself" do
    my_birthday = {{1981, 3, 5}, {2, 50, 0}}
    assert Gigasecond.from(my_birthday) == {{2012, 11, 11}, {4, 36, 40}}
  end
end
