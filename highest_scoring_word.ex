defmodule Kata do
  def high(str) do
    {_big_sum, big_word} =
      str
      |> String.split(" ")
      |> Enum.reduce({0, ""}, fn word, {big_sum, big_word} ->
        value = get_word_value(word, 0)

        case value > big_sum do
          true -> {value, word}
          _ -> {big_sum, big_word}
        end
      end)

    big_word
  end

  def get_word_value(<<>>, sum), do: sum

  def get_word_value(<<c, rest::binary>>, sum) do
    rest |> get_word_value(c - 96 + sum)
  end

  def high_improved(str) do
    String.split(str, " ")
    |> Enum.max_by(&_score(&1))
  end

  defp _score(word) do
    String.to_charlist(word)
    |> Enum.reduce(0, &(&1 + &2 - 96))
  end
end

# defmodule TestSolution do
#   use ExUnit.Case
#
#   @samples [
#     {"man i need a taxi up to ubud", "taxi"},
#     {"what time are we climbing up the volcano", "volcano"},
#     {"take me to semynak", "semynak"},
#     {"massage yes massage yes massage", "massage"},
#     {"take two bintang and a dance please", "bintang"},
#     {"aa b", "aa"},
#     {"b aa", "b"},
#     {"bb d", "bb"},
#     {"d bb", "d"},
#     {"aaa b", "aaa"},
#   ]
#
#   test "Sample test" do
#     Enum.map @samples, fn {input, output} ->
#       assert Kata.high(input) == output
#     end
#   end
#
#   test "Empty test" do
#     assert Kata.high("") == ""
#   end
# end
