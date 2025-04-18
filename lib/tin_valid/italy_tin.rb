# frozen_string_literal: true

module TinValid
  # rubocop:disable Metrics/ClassLength
  class ItalyTin
    include TinValid::Helpers

    def initialize(tin:, birth_date: nil)
      @tin = tin
      @birth_date = birth_date
    end

    attr_reader :tin, :birth_date

    def valid?
      match = MATCHER.match(tin)
      return false unless match
      return false unless valid_date?(match)

      tin[-1] == check
    end

    private

    def valid_date?(match)
      # C7,C8: Two last digits of a year.
      year = replacement_to_i(match[:year])

      # C9: A letter representing a month;
      month = MONTH_LETTERS.fetch(match[:month])

      # C10,C11: Day of month (in the range 1...31 for men)
      # or day of month + 40 (in the range 41...71 for women).
      day = replacement_to_i(match[:day])
      day -= 40 if day > 40

      if birth_date
        birth_date == date("#{birth_century}#{year}", month, day)
      else
        date("19#{year}", month, day) || date("20#{year}", month, day)
      end
    end

    def check
      # 1. Each of the first fifteen characters,depending on its relevant
      # position (even or odd), is converted into a numeric value,according to
      # correspondence shown in the tables below:
      sum = tin[..14].chars.each.with_index(1).sum do |char, index|
        index.even? ? even_number(char) : odd_number(char)
      end

      # 2. The numerical values thus determined are added together and their sum
      # is divided by 26. The check character (C16) is obtained by converting
      # the remainder of the division in the corresponding alphabetic character
      # according to the table below:
      ((sum % 26) + 65).chr
    end

    def birth_century = birth_date.strftime("%Y")[..1]

    def replacement_to_i(string)
      string.chars.map { NUMERICAL_REPLACEMENTS.fetch(_1, _1) }.join.to_i
    end

    MATCHER = %r{
      \A
      [A-Z]{6}
      (?<year>[0-9LMNPQRSTUV]{2})
      (?<month>[ABCDEHLMPRST])
      (?<day>[0-7LMNPQRST][0-9LMNPQRSTUV])
      [A-Z]
      [0-9LMNPQRSTUV]{3}
      [A-Z]
      \z
    }x
    private_constant :MATCHER

    # C9: A letter representing a month; the letter can only take the values:
    MONTH_LETTERS = {
      "A" => 1,
      "B" => 2,
      "C" => 3,
      "D" => 4,
      "E" => 5,
      "H" => 6,
      "L" => 7,
      "M" => 8,
      "P" => 9,
      "R" => 10,
      "S" => 11,
      "T" => 12
    }.freeze
    private_constant :MONTH_LETTERS

    NUMERICAL_REPLACEMENTS = {
      "L" => 0,
      "M" => 1,
      "N" => 2,
      "P" => 3,
      "Q" => 4,
      "R" => 5,
      "S" => 6,
      "T" => 7,
      "U" => 8,
      "V" => 9
    }.freeze
    private_constant :NUMERICAL_REPLACEMENTS

    def even_number(character)
      case character
      in "0".."9" then character.to_i
      in "A".."Z" then character.ord - 65
      end
    end

    def odd_number(character)
      ODD_NUMBER_TABLE.fetch(character)
    end

    ODD_NUMBER_TABLE = {
      "A" => 1,
      "0" => 1,
      "B" => 0,
      "1" => 0,
      "C" => 5,
      "2" => 5,
      "D" => 7,
      "3" => 7,
      "E" => 9,
      "4" => 9,
      "F" => 13,
      "5" => 13,
      "G" => 15,
      "6" => 15,
      "H" => 17,
      "7" => 17,
      "I" => 19,
      "8" => 19,
      "J" => 21,
      "9" => 21,
      "K" => 2,
      "L" => 4,
      "M" => 18,
      "N" => 20,
      "O" => 11,
      "P" => 3,
      "Q" => 6,
      "R" => 8,
      "S" => 12,
      "T" => 14,
      "U" => 16,
      "V" => 10,
      "W" => 22,
      "X" => 25,
      "Y" => 24,
      "Z" => 23
    }.freeze
    private_constant :ODD_NUMBER_TABLE
  end
  # rubocop:enable Metrics/ClassLength
end
