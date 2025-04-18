# frozen_string_literal: true

module TinValid
  class FranceTin
    def initialize(tin:)
      @tin = tin
    end

    attr_reader :tin

    def valid?
      return false unless /\A[0-3][0-9]{12}\z/.match?(tin)
      return false if tin == "0000000000000"

      tin[-3..].to_i == check
    end

    private

    def check
      # 1. Concatenate C1, C2, C3, C4, C5, C6, C7, C8, C9, C10;
      # 2. Get modulo 511 of the result of the previous result;
      # 3. Check digit = remainder if remainder < 100, C11 = 0
      # (if remainder < 10, C11 = 0 and C12 = 0).
      tin[..-4].to_i % 511
    end
  end
end
