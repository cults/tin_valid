# frozen_string_literal: true

module TinValid
  class SlovakiaTin
    include TinValid::Helpers

    def initialize(tin:, birth_date: nil)
      @tin = tin
      @birth_date = birth_date
    end

    attr_reader :tin, :birth_date

    def valid?
      return false if %w[0000000000 000000000 1234567890].include?(tin)

      valid_v2? || valid_v1?
    end

    def normalized = tin.tr("/", "")

    private

    MATCHER_V1 = %r{
      \A
      (?<year>[0-9]{2})
      (?<month>[0-6][0-9])
      (?<day>[0-3][0-9])
      /?
      [0-9]{3}
      (?<check>[0-9])?
      \z
    }x
    private_constant :MATCHER_V1

    MATCHER_V2 = %r{
      \A
      [0-9]{10}
      \z
    }x
    private_constant :MATCHER_V2

    # rubocop:disable Metrics/MethodLength
    def valid_v1?
      match = MATCHER_V1.match(tin)
      return false unless match

      year = match[:year].to_i
      return false if year >= 54 && match[:check].nil?

      if birth_date
        month = match[:month].to_i
        month -= 50 if month > 50

        tin_date = date("#{birth_century}#{year}", month, match[:day])
        return false if tin_date != birth_date
      end

      true
    end
    # rubocop:enable Metrics/MethodLength

    def valid_v2? = MATCHER_V2.match?(tin)

    def birth_century = birth_date.year.to_s[..1]
  end
end
