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

    def valid?
      !!instance&.valid?
    end

    def normalized
      instance.respond_to?(:normalized) ? instance.normalized : tin.to_s
    end

    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/CyclomaticComplexity
    # rubocop:disable Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength
    def instance
      @instance ||=
        case country_code
        in "at" then AustriaTin.new(tin:)
        in "be" then BelgiumTin.new(tin:, birth_date:)
        in "bg" then BulgariaTin.new(tin:, birth_date:)
        in "cy" then CyprusTin.new(tin:, kind:)
        in "cz" then CzechiaTin.new(tin:, birth_date:)
        in "de" then GermanyTin.new(tin:)
        in "dk" then DenmarkTin.new(tin:, birth_date:)
        in "ee" then EstoniaTin.new(tin:, birth_date:)
        in "es" then SpainTin.new(tin:)
        in "fi" then FinlandTin.new(tin:)
        in "fr" then FranceTin.new(tin:, kind:)
        in "gb" then UnitedKingdomTin.new(tin:)
        in "gr" then GreeceTin.new(tin:)
        in "hr" then CroatiaTin.new(tin:)
        in "hu" then HungaryTin.new(tin:)
        in "ie" then IrelandTin.new(tin:)
        in "it" then ItalyTin.new(tin:, birth_date:)
        in "lt" then LithuaniaTin.new(tin:, birth_date:)
        in "lu" then LuxembourgTin.new(tin:, birth_date:)
        in "lv" then LatviaTin.new(tin:, birth_date:)
        in "mt" then MaltaTin.new(tin:)
        in "nl" then NetherlandsTin.new(tin:)
        in "pl" then PolandTin.new(tin:, birth_date:)
        in "pt" then PortugalTin.new(tin:)
        in "ro" then RomaniaTin.new(tin:, birth_date:)
        in "se" then SwedenTin.new(tin:, birth_date:)
        in "si" then SloveniaTin.new(tin:)
        in "sk" then SlovakiaTin.new(tin:)
        end
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/CyclomaticComplexity
    # rubocop:enable Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength
  end
end
