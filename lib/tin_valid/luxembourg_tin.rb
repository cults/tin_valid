# frozen_string_literal: true

module TinValid
  class LuxembourgTin
    include TinValid::Helpers

    def initialize(tin:, birth_date: nil)
      @tin = tin
      @birth_date = birth_date
    end

    attr_reader :tin, :birth_date

    def valid?
      match = MATCHER.match(tin)
      return false unless match

      tin_date = date(match[:year], match[:month], match[:day])
      return false unless tin_date

      return false if birth_date && birth_date != tin_date

      check1? && check2?
    end

    private

    MATCHER = %r{
      \A
      (?<year>[0-9]{4})
      (?<month>[0-1][0-9])
      (?<day>[0-3][0-9])
      [0-9]{5}
      \z
    }x
    private_constant :MATCHER

    def check1?
      # 1. Multiply the values of each position by the corresponding weight:
      weights =
        [2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1]
          .each_with_index
          .map { |weight, index| weight * tin[index].to_i }

      # 2. If the product of a doubling operation is > 9, sum the digits of the
      # product;
      weights = weights.map { _1 > 9 ? _1.to_s.chars.sum(&:to_i) : _1 }

      # 3. Add up the results of the above multiplications;
      sum = weights.sum

      # 4. Get modulo 10 of the result of the previous addition;
      remainder = sum % 10

      # 5. If remainder = 0, C12 is valid. Otherwise the TIN is not valid.
      remainder == 0
    end

    def check2?
      # 1. Create an array n containing the individual C1 to C11 and C13 of the
      # TIN (where ni = the value of the corresponding C), taken from right to
      # left:
      array = [*tin[..10].chars, tin[12]].map(&:to_i).reverse

      # 2. Initialize the checksum c to 0;
      # 3. For each index i of the array n, starting at 0, replace c by
      # d(c,p(i mod 8, ni)), according to the following tables:
      checksum = array.each_with_index.inject(0) do |c, (ni, index)|
        table_d(c, table_p(index % 8, ni))
      end

      # 4. Check digit c if c = 0, C13 is valid. Otherwise, the TIN is not
      # valid.
      checksum == 0
    end

    def table_d(number_i, number_j) = TABLE_D.dig(number_i, number_j)
    def table_p(number_m, number_n) = TABLE_P.dig(number_m, number_n)

    TABLE_D = [
      [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
      [1, 2, 3, 4, 0, 6, 7, 8, 9, 5],
      [2, 3, 4, 0, 1, 7, 8, 9, 5, 6],
      [3, 4, 0, 1, 2, 8, 9, 5, 6, 7],
      [4, 0, 1, 2, 3, 9, 5, 6, 7, 8],
      [5, 9, 8, 7, 6, 0, 4, 3, 2, 1],
      [6, 5, 9, 8, 7, 1, 0, 4, 3, 2],
      [7, 6, 5, 9, 8, 2, 1, 0, 4, 3],
      [8, 7, 6, 5, 9, 3, 2, 1, 0, 4],
      [9, 8, 7, 6, 5, 4, 3, 2, 1, 0],
    ].freeze
    private_constant :TABLE_D

    TABLE_P = [
      [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
      [1, 5, 7, 6, 2, 8, 3, 0, 9, 4],
      [5, 8, 0, 3, 7, 9, 6, 1, 4, 2],
      [8, 9, 1, 6, 0, 4, 3, 5, 2, 7],
      [9, 4, 5, 3, 1, 2, 6, 8, 7, 0],
      [4, 2, 8, 6, 5, 7, 3, 9, 0, 1],
      [2, 7, 9, 3, 8, 0, 6, 4, 1, 5],
      [7, 0, 4, 6, 9, 1, 3, 2, 5, 8],
    ].freeze
    private_constant :TABLE_P
  end
end
