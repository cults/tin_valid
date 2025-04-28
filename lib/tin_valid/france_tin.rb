# frozen_string_literal: true

# https://www.economie.gouv.fr/cedef/fiches-pratiques/quest-ce-que-le-nif
module TinValid
  class FranceTin
    def initialize(tin:)
      @tin = tin
    end

    attr_reader :tin

    def valid? = valid_v1? || valid_siren?

    private

    def valid_v1?
      return false unless /\A[0-3][0-9]{12}\z/.match?(tin)
      return false if tin == "0000000000000"

      tin[-3..].to_i == check
    end

    # https://annuaire-entreprises.data.gouv.fr/definitions/numero-siren
    def valid_siren?
      return false if tin == "123456789"

      /\A[1-9][0-9]{8}\z/.match?(tin)
    end

    def check
      # 1. Concatenate C1, C2, C3, C4, C5, C6, C7, C8, C9, C10;
      # 2. Get modulo 511 of the result of the previous result;
      # 3. Check digit = remainder if remainder < 100, C11 = 0
      # (if remainder < 10, C11 = 0 and C12 = 0).
      tin[..-4].to_i % 511
    end
  end
end
