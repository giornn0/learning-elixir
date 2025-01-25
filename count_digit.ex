defmodule Countdigit do
  def nb_dig(number, digit) do
    Enum.to_list(0..number)
    |> Enum.reduce(0, fn num, acc ->
      acc + ((num * num) |> Integer.digits() |> Enum.count(&(&1 == digit)))
    end)
  end

  def nb_dig_improved(n, d) do
    0..n
    |> Stream.flat_map(&Integer.digits(&1 * &1))
    |> Enum.count(&(&1 == d))
  end
end

# defmodule CountdigitTest do
#
#   use ExUnit.Case
#
#   defp testing(numtest, num, d, ans) do 
#     IO.puts("Test #{numtest}")
#     assert Countdigit.nb_dig(num, d) == ans
#   end
#   test "nb_dig" do 
#     testing(1, 5750, 0, 4700)
# 		testing(2, 11011, 2, 9481)
# 		testing(3, 12224, 8, 7733)
# 		testing(4, 11549, 1, 11905)
#   end
# end
