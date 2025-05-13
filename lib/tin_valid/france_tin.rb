# frozen_string_literal: true

# https://www.economie.gouv.fr/cedef/fiches-pratiques/quest-ce-que-le-nif
module TinValid
  class FranceTin
    def initialize(tin:)
      @tin = tin
    end

    attr_reader :tin

    def valid? = valid_v1? || siren? || siret?

    # https://fr.wikipedia.org/wiki/Syst%C3%A8me_d%27identification_du_r%C3%A9pertoire_des_entreprises
    def siren?
      return false unless /\A[1-9][0-9]{8}\z/.match?(tin)
      return false if tin == "123456789"

      luhn_valid?
    end

    # https://fr.wikipedia.org/wiki/Syst%C3%A8me_d%27identification_du_r%C3%A9pertoire_des_%C3%A9tablissements
    def siret?
      return false unless /\A\d{14}\z/.match?(tin)
      return false if tin == "00000000000000"

      luhn_valid?
    end

    private

    def valid_v1?
      return false unless /\A[0-3][0-9]{12}\z/.match?(tin)
      return false if tin == "0000000000000"

      tin[-3..].to_i == v1_check
    end

    def v1_check
      # 1. Concatenate C1, C2, C3, C4, C5, C6, C7, C8, C9, C10;
      # 2. Get modulo 511 of the result of the previous result;
      # 3. Check digit = remainder if remainder < 100, C11 = 0
      # (if remainder < 10, C11 = 0 and C12 = 0).
      tin[..-4].to_i % 511
    end

    # https://en.wikipedia.org/wiki/Luhn_algorithm
    def luhn_valid?
      check = tin.chars.reverse.each_slice(2).sum do |a, b|
        a.to_i + (b.to_i * 2).to_s.chars.sum(&:to_i)
      end

      check % 10 == 0
    end
  end
end
