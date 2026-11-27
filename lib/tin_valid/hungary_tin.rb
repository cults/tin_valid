# frozen_string_literal: true

module TinValid
  class HungaryTin
    def initialize(tin:, kind: nil)
      @tin = tin
      @kind = kind
    end

    attr_reader :tin, :kind

    def valid? = valid_v1? || valid_v2? || valid_v3?

    def normalized = tin

    private

    def valid_v1?
      return false if kind && kind != "individual"
      return false unless /\A8[0-9]{9}\z/.match?(normalized)

      normalized[-1].to_i == check
    end

    def valid_v2?
      return false if kind && kind != "company"

      /\AHU[0-9]{8}\z/.match?(normalized)
    end

    def valid_v3?
      return false if kind && kind != "company"

      /\A[0-9]{8}-[0-9]-[0-9]{2}\z/.match?(normalized)
    end

    def check
      # 1. Multiply the values of each position by the corresponding weight:
      # 2. Add up the results of the above multiplications;
      result = (1..9).each_with_index.sum { |num, i| num * normalized[i].to_i }

      # 3. Get modulo 11 of the result of the previous addition;
      # 4. Check digit = remainder.
      result % 11
    end
  end
end
