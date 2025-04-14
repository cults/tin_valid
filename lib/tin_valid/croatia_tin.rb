# frozen_string_literal: true

module TinValid
  class CroatiaTin < Data.define(:tin)
    def valid?
      return false unless /\A[0-9]{11}\z/.match?(tin)

      tin[-1].to_i == check
    end

    private

    # Check digit by the international standard ISO 7064 (MOD 11, 10).
    def check
      last_rest = tin[..-2].chars.inject(10) do |rest, digit|
        # 1. C1 is summed with 10
        sum = digit.to_i + rest

        # 2. The sum integer is divided by 10, and the rest is kept;
        # if that number is 0 it gets replaced by number 10 (this latter number
        # is called subtotal);
        subtotal = sum % 10 == 0 ? 10 : sum % 10

        # 3. The obtained subtotal is multiplied by 2
        subtotal *= 2

        # 4. The obtained number is divided by 11, and the rest is kept; this
        # number mathematically cannot be 0 because the result of the previous
        # step is always an even number
        #
        # 5. The next digit is summed with the rest from the previous step;
        # 6. Steps 2, 3, 4 and 5 are repeated until all digits are expanded
        subtotal % 11
      end

      # 7. If the rest of the final step is equal to 1, the check digit is 0.
      # Otherwise, the check digit is a difference between 11 and the rest in
      # the last step
      last_rest == 1 ? 0 : 11 - last_rest
    end
  end
end
