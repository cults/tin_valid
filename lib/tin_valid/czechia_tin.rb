# frozen_string_literal: true

module TinValid
  class CzechiaTin
    include TinValid::Helpers

    def initialize(tin:, birth_date: nil)
      @tin = tin
      @birth_date = birth_date
    end

    attr_reader :tin, :birth_date

    def valid? = valid_v1? || valid_v2?

    private

    MATCHER_V1 = %r{
      \A
      (?<year>[0-9]{2})
      (?<month>[0156][0-9])
      (?<day>[0-3][0-9])
      /?
      [0-9]{3}
      \z
    }x
    private_constant :MATCHER_V1

    MATCHER_V2 = %r{
      \A
      (?<year>[0-9]{2})
      (?<month>[0-8][0-9])
      (?<day>[0-3][0-9])
      /?
      [0-9]{4}
      \z
    }x
    private_constant :MATCHER_V2

    def valid_v1?
      match = MATCHER_V1.match(tin)
      return false unless match
      return false if tin == "000000000"
      return true if birth_date.nil?
      return false if year_of_birth >= 1954

      year = "#{birth_century}#{match[:year]}"

      # Month (in the range 1...12 for men) or month + 50 (in the range 51…62
      # for women).
      month = match[:month].to_i
      month -= 50 if month > 50

      birth_date == date(year, month, match[:day])
    end

    def valid_v2?
      match = MATCHER_V2.match(tin)
      return false unless match
      return false if tin == "0000000000"
      return true if birth_date.nil?
      return false if year_of_birth < 1954

      # Two last digits of a year: Must be within the range:
      # 00 - last two digits of current year for people born in 2000 and later;
      # 54 - 99 for people born between 1954 and 1999.
      year = "#{birth_century}#{match[:year]}"

      birth_date == date(year, month_integer(match[:month]), match[:day])
    end

    def year_of_birth = birth_date&.year
    def birth_century = birth_date.strftime("%Y")[..1]

    # Month (in the range 1...12 only for men) or month + 20 (in the range
    # 21…32 only for men) or month + 50 (in the range 51...62 only for women)
    # or month + 70 (in the range 71…82 only for women).
    def month_integer(number)
      number = number.to_i
      if number > 70
        number - 70
      elsif number > 50
        number - 50
      elsif number > 20
        number - 20
      else
        number
      end
    end
  end
end
