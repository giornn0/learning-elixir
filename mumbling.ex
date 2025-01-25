defmodule Mumbling do
  def accum(s) do
    list =
      for <<char <- s>>,
          <<char>> != "",
          into: [],
          do: <<char>> |> String.upcase()

    list |> append_repetions(0, []) |> Enum.reverse() |> Enum.join("-")
  end

  defp append_repetions([], _, result), do: result

  defp append_repetions([head | tail], repeat, res) do
    append_repetions(
      tail,
      repeat + 1,
      [head <> (head |> String.downcase() |> String.duplicate(repeat)) | res]
    )
  end

  def accum(s) do
    String.graphemes(s)
    |> Enum.with_index(1)
    |> Enum.map_join("-", fn {elem, times} ->
      String.duplicate(elem, times) |> String.capitalize()
    end)
  end
end

# defmodule MumblingTest do
#   use ExUnit.Case
#
#   defp testing(numtest, s, ans) do
#     IO.puts("Test #{numtest} \n")
#     assert Mumbling.accum(s) == ans
#   end
#
#   test "accum" do
#     testing(
#       1,
#       "ZpglnRxqenU",
#       "Z-Pp-Ggg-Llll-Nnnnn-Rrrrrr-Xxxxxxx-Qqqqqqqq-Eeeeeeeee-Nnnnnnnnnn-Uuuuuuuuuuu"
#     )
#
#     testing(
#       2,
#       "NyffsGeyylB",
#       "N-Yy-Fff-Ffff-Sssss-Gggggg-Eeeeeee-Yyyyyyyy-Yyyyyyyyy-Llllllllll-Bbbbbbbbbbb"
#     )
#
#     testing(
#       3,
#       "MjtkuBovqrU",
#       "M-Jj-Ttt-Kkkk-Uuuuu-Bbbbbb-Ooooooo-Vvvvvvvv-Qqqqqqqqq-Rrrrrrrrrr-Uuuuuuuuuuu"
#     )
#
#     testing(
#       4,
#       "EvidjUnokmM",
#       "E-Vv-Iii-Dddd-Jjjjj-Uuuuuu-Nnnnnnn-Oooooooo-Kkkkkkkkk-Mmmmmmmmmm-Mmmmmmmmmmm"
#     )
#
#     testing(
#       5,
#       "HbideVbxncC",
#       "H-Bb-Iii-Dddd-Eeeee-Vvvvvv-Bbbbbbb-Xxxxxxxx-Nnnnnnnnn-Cccccccccc-Ccccccccccc"
#     )
#   end
# end
