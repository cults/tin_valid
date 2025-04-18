# frozen_string_literal: true

module TinValid
  class IrelandTin
    def initialize(tin:)
      @tin = tin
    end

    attr_reader :tin

    def valid?
      /\A[0-9]{7}[A-W][A-IW]?\z/.match?(tin) &&
        tin.chars[7] == check
    end

    private

    # rubocop:disable Metrics/AbcSize
    def check
      # 1. In reverse order, each digit is multiplied by a weight started at 2:
      weights = 8.downto(2)
      digits = weights.with_index.map { |weight, i| weight * tin.chars[i].to_i }

      # 2. LetterToNumber(C9) is based on the following mapping:
      # “A”=1, “B”=2, “C”=3, “D”=4, “E”=5, “F”=6, “G”=7, “H”=8, “I”=9
      # A “W” or absence of character in position 9 is allocated a numeric
      # value of 0.
      digits.push letter_to_number(tin.chars[9 - 1]) * 9

      # 3. Add up each result;
      sum = digits.sum

      # 4. The remainder of the modulo 23 indicates the character position on
      # the alphabet according to the following mapping:
      # 0=”W”, 1=”A”, 2=”B”, 3=”C”… 22=”V”
      number_to_letter(sum % 23)
    end
    # rubocop:enable Metrics/AbcSize

    def letter_to_number(letter)
      return 0 if letter.nil?

      case letter
      in "W" then 0
      in "A".."I" then letter.ord - 64
      end
    end

    def number_to_letter(number)
      case number
      in 0 then "W"
      in 1..22 then (number + 64).chr
      end
    end
  end
end
