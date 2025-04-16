# frozen_string_literal: true

module TinValid
  class HungaryTin < Data.define(:tin)
    def valid?
      return false unless /\A8[0-9]{9}\z/.match?(tin)

      tin[-1].to_i == check
    end

    private

    def check
      # 1. Multiply the values of each position by the corresponding weight:
      # 2. Add up the results of the above multiplications;
      result = (1..9).each_with_index.sum { |num, i| num * tin[i].to_i }

      # 3. Get modulo 11 of the result of the previous addition;
      # 4. Check digit = remainder.
      result % 11
    end
  end
end
