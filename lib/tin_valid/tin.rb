# frozen_string_literal: true

module TinValid
  class Tin
    def initialize(country_code:, tin:, birth_date: nil, kind: nil)
      @country_code = country_code.to_s.downcase
      @tin = tin
      @birth_date = birth_date
      @kind = kind
    end

    attr_reader :country_code, :tin, :birth_date, :kind

    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/CyclomaticComplexity
    # rubocop:disable Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength
    def valid?
      case country_code
      in "at" then AustriaTin.new(tin:).valid?
      in "be" then BelgiumTin.new(tin:, birth_date:).valid?
      in "bg" then BulgariaTin.new(tin:, birth_date:).valid?
      in "cy" then CyprusTin.new(tin:, kind:).valid?
      in "cz" then CzechiaTin.new(tin:, birth_date:).valid?
      in "de" then GermanyTin.new(tin:).valid?
      in "dk" then DenmarkTin.new(tin:, birth_date:).valid?
      in "ee" then EstoniaTin.new(tin:, birth_date:).valid?
      in "es" then SpainTin.new(tin:).valid?
      in "fi" then FinlandTin.new(tin:).valid?
      in "fr" then FranceTin.new(tin:).valid?
      in "gb" then UnitedKingdomTin.new(tin:).valid?
      in "gr" then GreeceTin.new(tin:).valid?
      in "hr" then CroatiaTin.new(tin:).valid?
      in "hu" then HungaryTin.new(tin:).valid?
      in "ie" then IrelandTin.new(tin:).valid?
      in "it" then ItalyTin.new(tin:, birth_date:).valid?
      in "lt" then LithuaniaTin.new(tin:, birth_date:).valid?
      in "lu" then LuxembourgTin.new(tin:, birth_date:).valid?
      in "lv" then LatviaTin.new(tin:, birth_date:).valid?
      in "mt" then MaltaTin.new(tin:).valid?
      in "nl" then NetherlandsTin.new(tin:).valid?
      in "pl" then PolandTin.new(tin:, birth_date:).valid?
      in "pt" then PortugalTin.new(tin:).valid?
      in "ro" then RomaniaTin.new(tin:, birth_date:).valid?
      in "se" then SwedenTin.new(tin:, birth_date:).valid?
      in "si" then SloveniaTin.new(tin:).valid?
      in "sk" then SlovakiaTin.new(tin:).valid?
      end
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/CyclomaticComplexity
    # rubocop:enable Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength
  end
end
