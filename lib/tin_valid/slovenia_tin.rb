# frozen_string_literal: true

module TinValid
  class SloveniaTin < Data.define(:tin)
    def valid?
      return false unless /\A[1-9][0-9]{7}\z/.match?(tin)

      tin[-1].to_i == check
    end

    private

    def check
      # Multiply the values of each position by the corresponding weight:
      weights =
        8
          .downto(2)
          .each_with_index
          .map { |weight, index| weight * tin[index].to_i }

      # 2. Add up the results of the above multiplications;
      sum = weights.sum

      # 3. Get modulo 11 of the result of the previous addition;
      remainder = sum % 11

      # 4. Check digit = 11 - remainder. If result = 10, Check digit = 0.
      digit = 11 - remainder
      digit == 10 ? 0 : digit
    end
  end
end
