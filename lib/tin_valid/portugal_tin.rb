# frozen_string_literal: true

module TinValid
  class PortugalTin < Data.define(:tin)
    def valid?
      return false unless /\A[0-9]{9}\z/.match?(tin)
      return false if tin == "000000000"
      return false if tin == "123456789"

      tin[-1].to_i == check
    end

    private

    def check
      # 1. Multiply the values of each position by the corresponding weight:
      multipliers =
        9
          .downto(2)
          .with_index
          .map { |multiplier, index| multiplier * tin[index].to_i }

      # 2. Add up the results of the above multiplications;
      sum = multipliers.sum

      # 3. Get modulo 11 of the result of the previous addition;
      remainder = sum % 11

      # 4. Check digit = 11 - remainder:
      digit = 11 - remainder

      # If check digit < = 9 then check digit is OK (11 – remainder);
      return digit if digit <= 9

      # If check digit = 10 then check digit is 0 (zero);
      # If check digit = 11 then check digit is 0 (zero).
      0
    end
  end
end
