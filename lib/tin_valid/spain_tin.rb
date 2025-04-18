# frozen_string_literal: true

module TinValid
  class SpainTin
    def initialize(tin:)
      @tin = tin
    end

    attr_reader :tin

    def valid?
      valid_v1? || valid_v2?
    end

    private

    def valid_v1?
      return false unless /\A[0-9]{1,8}[A-Z]\z/.match?(tin)

      tin[-1] == check_letter(tin)
    end

    def valid_v2?
      return false unless /\A[XYZKLM][0-9]{7}[A-Z]\z/.match?(tin)

      tin[-1] == check_v2
    end

    def check_v2
      # 0. Replace the leading letter by the corresponding digit and concatenate
      # the result with the other characters:
      digit =
        case tin[0]
        when "X", "K", "L", "M" then 0
        when "Y" then 1
        when "Z" then 2
        end

      check_letter("#{digit}#{tin[1..]}")
    end

    def check_letter(code)
      # 1. Take the remainder of modulo 23 of the 8 first characters;
      remainder = code[..-2].to_i % 23

      # 2. Add 1 to the remainder of operation 1;
      # 3. The check letter corresponds to this figure in the table below:
      "TRWAGMYFPDXBNJZSQVHLCKE"[remainder]
    end
  end
end
