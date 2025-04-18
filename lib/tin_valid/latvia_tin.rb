# frozen_string_literal: true

module TinValid
  class LatviaTin
    def initialize(tin:, birth_date: nil)
      @tin = tin
      @birth_date = birth_date
    end

    attr_reader :tin, :birth_date

    def valid? = valid_v1? || valid_v2?

    private

    MATCHER_V1 = %r{
      \A
      (?<day>[0-3][0-9])
      (?<month>[0-1][0-9])
      (?<year>[0-9]{2})
      (?<century>[0-2])
      -?
      [0-9]{4}
      \z
    }x
    private_constant :MATCHER_V1

    MATCHER_V2 = %r{
      \A
      32
      [0-9]{4}
      -?
      [0-9]{5}
      \z
    }x
    private_constant :MATCHER_V2

    def valid_v1?
      match = MATCHER_V1.match(tin)
      return false unless match
      return false if tin == "00000000000"

      if birth_date
        tin[..5] == birth_date.strftime("%d%m%y") &&
          tin[6] == birth_century_digit
      else
        true
      end
    end

    def valid_v2?
      MATCHER_V2.match?(tin)
    end

    def birth_century_digit
      case birth_date.year
      when 1800..1899 then "0"
      when 1900..1999 then "1"
      when 2000.. then "2"
      end
    end
  end
end
