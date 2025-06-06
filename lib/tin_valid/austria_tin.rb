# frozen_string_literal: true

module TinValid
  class AustriaTin
    def initialize(tin:)
      @tin = tin
    end

    attr_reader :tin

    def valid?
      return false unless MATCHER.match?(normalized)
      return false if %w[000000000 123456789].include?(normalized)

      normalized[-1] == check
    end

    def normalized
      @normalized ||= tin.to_s.strip.tr("-/", "")
    end

    private

    MATCHER = %r{\A[0-9]{2}-?[0-9]{3}/?[0-9]{4}\z}
    private_constant :MATCHER

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
        normalized
          .chars[..-2]
          .each_with_index
          .map { |n, i| n.to_i * (i.even? ? 1 : 2) }

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
