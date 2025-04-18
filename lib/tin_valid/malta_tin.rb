# frozen_string_literal: true

module TinValid
  class MaltaTin
    def initialize(tin:)
      @tin = tin
    end

    attr_reader :tin

    def valid? = valid_format_1? || valid_format_2?

    private

    MATCHER_V1 = %r{
      \A
      (?<number>
        (?<part1>[0-9]{0,5})
        [0-9]{1,2}
      )
      (?<letter>[MGAPLHBZ])
      \z
    }x
    private_constant :MATCHER_V1

    MATCHER_V2 = %r{
      \A
      (11|22|33|44|55|66|77|88)
      [0-9]{7}
      \z
    }x
    private_constant :MATCHER_V2

    def valid_format_1?
      match = MATCHER_V1.match(tin)
      return false unless match

      case match[:letter]
      when "A", "P"
        true
      when "M", "G", "L", "H", "B", "Z"
        (0..32_000).cover?(match[:part1].to_i) &&
          match[:number].to_i != 0
      end
    end

    def valid_format_2?
      MATCHER_V2.match?(tin)
    end
  end
end
