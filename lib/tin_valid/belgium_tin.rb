# frozen_string_literal: true

module TinValid
  class BelgiumTin
    include TinValid::Helpers

    def initialize(tin:, birth_date: nil)
      @tin = tin
      @birth_date = birth_date
    end

    def valid?
      return false unless match

      number = tin[..-3]
      valid_check?("19#{year}", month, day, number) ||
        valid_check?("20#{year}", month, day, "2#{number}")
    end

    private

    attr_reader :tin, :birth_date

    MATCHER = %r{
      \A
      (?<year>[0-9]{2})
      (?<month>[0-1][0-9])
      (?<day>[0-3][0-9])
      [0-9]{3}
      (?<check>[0-9]{2})
      \z
    }x
    private_constant :MATCHER

    def match = @match ||= MATCHER.match(tin)
    def year = match[:year]
    def month = match[:month]
    def day = match[:day]
    def check = match[:check].to_i

    def valid_check?(year, month, day, number)
      # A month (in the range 00...12, 00 is acceptable for person not born in
      # Belgium and with an uncertain date of birth).
      month = 1 if month == "00"

      # A day of month (in the range 00...31 depending on month and year, 00 is
      # acceptable for person not born in Belgium and with an uncertain date of
      # birth).
      day = 1 if day == "00"

      tin_date = date(year, month, day)
      return false if tin_date.nil?
      return false if birth_date && birth_date != tin_date

      check == digit_check(number)
    end

    # 1. Get the remainder of the division by 97 of the number composed by
    # C1, C2, C3, C4, C5, C6, C7, C8 and C9;
    #
    # Also, alternatively:
    #
    # 1. Get the remainder of the division by 97 of the number composed by
    # number 2 and C1, C2, C3, C4, C5, C6, C7, C8 and C9;
    #
    # 2. 97 - remainder of the previous division is the check number
    def digit_check(number) = 97 - (number.to_i % 97)
  end
end
