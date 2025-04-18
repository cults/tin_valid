# frozen_string_literal: true

module TinValid
  class PolandTin
    include TinValid::Helpers

    def initialize(tin:, birth_date: nil)
      @tin = tin
      @birth_date = birth_date
    end

    attr_reader :tin, :birth_date

    def valid? = valid_v1? || valid_v2?

    private

    MATCHER_V1 = /\A[0-9]{10}\z/
    private_constant :MATCHER_V1

    MATCHER_V2 = %r{
      \A
      (?<year>[0-9]{2})
      (?<month>[0-9]{2})
      (?<day>[0-3][0-9])
      [0-9]{5}
      \z
    }x
    private_constant :MATCHER_V2

    def valid_v1?
      return false unless MATCHER_V1.match?(tin)
      return false if tin == "0000000000"

      tin[-1].to_i == check
    end

    def valid_v2?
      match = MATCHER_V2.match(tin)
      return false unless match
      return false if tin == "00000000000"
      return true unless birth_date

      tin_date = date(
        "#{birth_century}#{match[:year]}",
        match[:month].to_i - month_increase,
        match[:day],
      )
      tin_date == birth_date
    end

    def check
      # 1. Multiply the values of each position by the corresponding weight:
      weights =
        [6, 5, 7, 2, 3, 4, 5, 6, 7]
          .each_with_index
          .map { |weight, index| weight * tin[index].to_i }

      # 2. Add up the results of the above multiplications;
      sum = weights.sum

      # 3. Get modulo 11 of the result of the previous addition;
      # 4. Check digit = remainder (if remainder = 10, the TIN is not valid).
      sum % 11
    end

    def birth_century = birth_date.year.to_s[..1].to_i

    def month_increase
      case birth_century
      when 18 then 80
      when 20 then 20
      when 21 then 40
      when 22 then 60
      else 0
      end
    end
  end
end
