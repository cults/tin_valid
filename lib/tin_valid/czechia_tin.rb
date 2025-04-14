# frozen_string_literal: true

module TinValid
  class CzechiaTin < Data.define(:tin, :birth_date)
    def initialize(tin:, birth_date: nil)
      super
    end

    def valid? = valid_v1? || valid_v2?

    private

    MATCHER_V1 = %r{
      \A
      (?<year>[0-9]{2})
      (?<month>[0156][0-9])
      (?<day>[0-3][0-9])
      [0-9]{3}
      \z
    }x
    private_constant :MATCHER_V1

    MATCHER_V2 = %r{
      \A
      (?<year>[0-9]{2})
      (?<month>[0-8][0-9])
      (?<day>[0-3][0-9])
      [0-9]{4}
      \z
    }x
    private_constant :MATCHER_V2

    def valid_v1?
      match = MATCHER_V1.match(tin)
      return false unless match
      return true if birth_date.nil?
      return false if year_of_birth >= 1954

      year = "#{birth_century}#{match[:year]}"

      # Month (in the range 1...12 for men) or month + 50 (in the range 51…62
      # for women).
      month = match[:month].to_i
      month -= 50 if month > 50

      birth_date == date(year, month, match[:day])
    end

    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/MethodLength
    def valid_v2?
      match = MATCHER_V2.match(tin)
      return false unless match
      return true if birth_date.nil?
      return false if year_of_birth < 1954

      # Two last digits of a year: Must be within the range:
      # 00 - last two digits of current year for people born in 2000 and later;
      # 54 - 99 for people born between 1954 and 1999.
      year = "#{birth_century}#{match[:year]}"

      # Month (in the range 1...12 only for men) or month + 20 (in the range
      # 21…32 only for men) or month + 50 (in the range 51...62 only for women)
      # or month + 70 (in the range 71…82 only for women).
      month = match[:month].to_i
      if month > 70
        month -= 70
      elsif month > 50
        month -= 50
      elsif month > 20
        month -= 20
      end

      birth_date == date(year, month, match[:day])
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/MethodLength

    def year_of_birth = birth_date&.year
    def birth_century = birth_date.strftime("%Y")[..1]

    def date(year, month, day)
      Date.new(year.to_i, month.to_i, day.to_i)
    rescue Date::Error
      nil
    end
  end
end
