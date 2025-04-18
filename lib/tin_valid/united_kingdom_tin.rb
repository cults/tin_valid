# frozen_string_literal: true

module TinValid
  class UnitedKingdomTin
    def initialize(tin:)
      @tin = tin
    end

    attr_reader :tin

    def valid?
      valid_v1? || valid_v2?
    end

    private

    def valid_v1?
      return false if %w[1234567890 0000000000].include?(tin)

      /\A[0-9]{10}\z/.match?(tin)
    end

    def valid_v2?
      return false unless /\A[A-Z]{2}[0-9]{6}[A-D]?\z/.match?(tin)
      return false if %w[D F I Q U V].include?(tin[0])
      return false if %w[D F I Q O U V].include?(tin[1])
      return false if %w[GB NK TN ZZ].include?(tin[0..1])

      true
    end
  end
end
