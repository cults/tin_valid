# frozen_string_literal: true

module TinValid
  class CyprusTin < Data.define(:tin, :kind)
    def initialize(tin:, kind: nil)
      super
    end

    def valid?
      matcher.match?(tin) && check == tin[-1]
    end

    private

    def matcher
      if kind == "individual"
        /\A[069][0-9]{7}[A-Z]\z/
      elsif kind == "company"
        /\A[1234578][0-9]{7}[A-Z]\z/
      else
        /\A[0-9]{8}[A-Z]\z/
      end
    end

    def check
      # 1. Add up the numbers in the even positions;
      even_sum = numbers.each_with_index.sum do |number, index|
        index.odd? ? number : 0
      end

      # 2. Consider all the numbers at the odd positions of the field and for
      # each number find the corresponding value from the table below, and add
      # them up:
      odd_number_values = [1, 0, 5, 7, 9, 13, 15, 17, 19, 21]
      odd_sum = numbers.each_with_index.sum do |number, index|
        index.even? ? odd_number_values[number] : 0
      end

      # 3. Add the two sums obtained;
      addition = even_sum + odd_sum

      # 4. Get modulo 26 of the result of the previous addition;
      remainder = addition % 26

      # 5. Remainder + 65 gives the American Standard Code for Information
      # Interchange (ASCII) code of a character (A to Z) which is the check
      # character.
      (remainder + 65).chr
    end

    def numbers = tin[..-2].chars.map(&:to_i)
  end
end
