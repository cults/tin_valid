# frozen_string_literal: true

module TinValid
  class LithuaniaTin
    def initialize(tin:, birth_date: nil)
      @tin = tin
      @birth_date = birth_date
    end

    attr_reader :tin, :birth_date

    def valid?
      matcher = MATCHER.match(tin)
      return false unless matcher

      if birth_date && (matcher[:birth_date] != birth_date.strftime("%y%m%d"))
        return false
      end

      tin[-1].to_i == check
    end

    private

    MATCHER = %r{
      [1-6]
      (?<birth_date>
        [0-9]{2}
        [0-1][0-9]
        [0-3][0-9]
      )
      [0-9]{4}
    }x
    private_constant :MATCHER

    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/MethodLength
    def check
      # 1. Multiply the values of each position by the corresponding weight:
      weights =
        [1, 2, 3, 4, 5, 6, 7, 8, 9, 1]
          .each_with_index
          .map { |weight, index| weight * tin[index].to_i }

      # 2. Add up the results of the above multiplications;
      sum = weights.sum

      # 3. Get modulo 11 of the result of the previous addition;
      remainder = sum % 11

      # 4. C11 = remainder if remainder is not 10;
      return remainder if remainder != 10

      # 5. If remainder is 10, calculate a new check digit with over
      # corresponding weight:
      weights =
        [3, 4, 5, 6, 7, 8, 9, 1, 2, 3]
          .each_with_index
          .map { |weight, index| weight * tin[index].to_i }

      # 6. Add up the results of the above multiplications;
      sum = weights.sum

      # 7. Get modulo 11 of the result of the previous addition;
      remainder = sum % 11

      # 8. C11 = remainder if remainder is not 10; if remainder is 10, C11 = 0.
      return remainder if remainder != 10

      0
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/MethodLength
  end
end
