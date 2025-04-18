# frozen_string_literal: true

module TinValid
  class FinlandTin
    include TinValid::Helpers

    def initialize(tin:, birth_date: nil)
      @tin = tin
      @birth_date = birth_date
    end

    attr_reader :tin, :birth_date

    def valid?
      match = MATCHER.match(tin)
      return false unless match

      tin_date = date(
        "#{tin_century(match[:century])}#{match[:year]}",
        match[:month],
        match[:day],
      )
      return false unless tin_date
      return false if birth_date && birth_date != tin_date

      tin[-1] == check
    end

    private

    MATCHER = %r{
      \A
      (?<day>[0-3][0-9])
      (?<month>[0-1][0-9])
      (?<year>[0-9][0-9])
      (?<century>[-+A-FU-Y])
      [0-9]{3}
      [0-9A-Z]
      \z
    }x
    private_constant :MATCHER

    def tin_century(character)
      case character
      when "+" then 18
      when "-", "U", "V", "W", "X", "Y" then 19
      else 20
      end
    end

    def check
      # 1. Concatenate C1, C2, C3, C4, C5, C6, C8, C9, C10
      # (warning: C7 is not part of the check digit);
      number = "#{tin[0..5]}#{tin[7..9]}".to_i

      # 2. Calculate the modulo 31 of the abovementioned number;
      remainder = number % 31

      # 4. The result of calculating modulo 31 will give as a result a number,
      # which will provide the check mark through the following table:
      case remainder
      when ..9 then remainder.to_s
      when ..15 then (remainder + 55).chr
      when 16 then "H"
      when ..21 then (remainder + 57).chr
      when 21 then "P"
      else (remainder + 59).chr
      end
    end
  end
end
