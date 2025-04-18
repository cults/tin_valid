# frozen_string_literal: true

module TinValid
  class GreeceTin
    def initialize(tin:)
      @tin = tin
    end

    attr_reader :tin

    def valid?
      return false unless /\A[0-9]{9}\z/.match?(tin)

      tin != "000000000" && tin != "123456789"
    end
  end
end
