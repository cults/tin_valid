# frozen_string_literal: true

module TinValid
  class AustriaTin < Data.define(:tin)
    def valid?
      return false unless /\A[0-9]{9}\z/.match?(tin)

      tin[-1] == check
    end

    private

    # rubocop:disable Metrics/AbcSize
    def check
      # 1. Multiply the values of each position by the corresponding weight:
      # - C1: 1
      # - C2: 2
      # - C3: 1
      # - C4: 2
      # - C5: 1
      # - C6: 2
      # - C7: 1
      # - C8: 2
      values_by_weight =
        tin
          .chars
          .each_with_index
          .map { |n, i| n.to_i * (i.even? ? 2 : 1) }

      # 2. If the product of a doubling operation is > 9, sum the digits of the
      # product;
      values_by_weight =
        values_by_weight.map { |n| n > 9 ? n.to_s.chars.sum(&:to_i) : n }

      # 3. Add up the results of the above multiplications;
      sum = values_by_weight.sum

      # 4. The result of the sum of the digits is subtracted from 100 and the
      # unit digit of this operation is the check digit.
      (100 - sum).to_s[-1]
    end
    # rubocop:enable Metrics/AbcSize
  end
end
