defmodule ArabicToRoman do
  def solution(number) do
    # Happy coding!  
    solution_improved(@roman_values, number, "")
  end

  def solution(number, result) when number == 0, do: result

  def solution(number, result) when 4 == number do
    solution(number - 4, result <> "IV")
  end

  def solution(number, result) when 9 == number do
    solution(number - 9, result <> "IX")
  end

  def solution(number, result) when 40 <= number and number < 50 do
    solution(number - 40, result <> "XL")
  end

  def solution(number, result) when 90 <= number and number < 100 do
    solution(number - 90, result <> "XC")
  end

  def solution(number, result) when 400 <= number and number < 500 do
    solution(number - 400, result <> "CD")
  end

  def solution(number, result) when 900 <= number and number < 1000 do
    solution(number - 900, result <> "CM")
  end

  def solution(number, result) when 1000 <= number and number < 4000 do
    solution(number - 1000, result <> "M")
  end

  def solution(number, result) when 500 <= number and number < 900 do
    solution(number - 500, result <> "D")
  end

  def solution(number, result) when 100 <= number and number < 400 do
    solution(number - 100, result <> "C")
  end

  def solution(number, result) when 50 <= number and number < 90 do
    solution(number - 50, result <> "L")
  end

  def solution(number, result) when 10 <= number and number < 40 do
    solution(number - 10, result <> "X")
  end

  def solution(number, result) when 5 <= number and number < 9 do
    solution(number - 5, result <> "V")
  end

  def solution(number, result) when 1 <= number and number < 4 do
    solution(number - 1, result <> "I")
  end

  @roman_values [
    {"M", 1000},
    {"CM", 900},
    {"D", 500},
    {"CD", 400},
    {"C", 100},
    {"XC", 90},
    {"L", 50},
    {"XL", 40},
    {"X", 10},
    {"IX", 9},
    {"V", 5},
    {"IV", 4},
    {"I", 1}
  ]
  def solution_improved([], 0, result), do: result

  def solution_improved([{roman, value} | tail], number, result) do
    solution_improved(
      tail,
      number |> rem(value),
      result <> (roman |> String.duplicate(number |> div(value)))
    )
  end
end
