# frozen_string_literal: true

module TinValid
  class RomaniaTin
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
      (?<century_code>[1-9])
      (?<year>[0-9]{2})
      (?<month>[0-1][0-9])
      (?<day>[0-3][0-9])
      (?<district>[0-5][0-9])
      [0-9]{4}
      \z
    }x
    private_constant :MATCHER_V1

    MATCHER_V2 = %r{
      \A
      9
      000
      [0-9]{8,9}
      \z
    }x
    private_constant :MATCHER_V2

    # rubocop:disable Metrics/CyclomaticComplexity
    # rubocop:disable Metrics/MethodLength
    def valid_v1?
      match = MATCHER_V1.match(tin)
      return false unless match
      return false unless valid_district?(match[:district])

      century = tin_century_from_code(match[:century_code]) || birth_century
      if century
        tin_date = date(
          "#{century}#{match[:year]}",
          match[:month],
          match[:day],
        )
        return false if tin_date.nil?
        return false if birth_date && tin_date != birth_date
      end

      true
    end
    # rubocop:enable Metrics/CyclomaticComplexity
    # rubocop:enable Metrics/MethodLength

    def valid_v2? = MATCHER_V2.match?(tin)

    def valid_district?(district)
      case district.to_i
      when 1..47, 51..52 then true
      else false
      end
    end

    def birth_century
      birth_date.year.to_s[..1] if birth_date
    end

    def tin_century_from_code(code)
      case code.to_i
      when 1..2 then 19
      when 3..4 then 18
      when 5..6 then 20
      end
    end
  end
end
