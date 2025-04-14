# frozen_string_literal: true

module TinValid
  class GreeceTin < Data.define(:tin)
    def valid?
      /\A[0-9]{9}\z/.match?(tin)
    end
  end
end
