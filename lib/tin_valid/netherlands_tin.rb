# frozen_string_literal: true

module TinValid
  class NetherlandsTin
    def initialize(tin:)
      @tin = tin
    end

    attr_reader :tin

    def valid?
      return false unless /\A[0-9]{9}\z/.match?(tin)
      return false if tin == "000000000"

      tin[-1].to_i == check
    end

    private

    def check
      # 1. Multiply the values of each position by the corresponding weight:
      multipliers =
        9
          .downto(2)
          .each_with_index
          .map { |multiplier, position| multiplier * tin[position].to_i }

      # 2. Add up the results of the above multiplications;
      sum = multipliers.sum

      # 3. Get modulo 11 of the result of the previous addition;
      # 4. Check digit = remainder (if remainder = 10, the TIN is not valid).
      sum % 11
    end
  end
end
