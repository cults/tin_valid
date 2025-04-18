# frozen_string_literal: true

module TinValid
  class EstoniaTin < Data.define(:tin, :birth_date)
    def initialize(tin:, birth_date: nil)
      super
    end

    def valid?
      match = MATCHER.match(tin)
      return false unless match
      return false unless (1..710).cover?(match[:id].to_i)

      if birth_date
        year = "#{birth_century}#{match[:year]}"
        return false if birth_date != date(year, match[:month], match[:day])
      end

      match[:check].to_i == checksum
    end

    private

    MATCHER = %r{
      \A
      [1-6]
      (?<year>[0-9]{2})
      (?<month>[0-1][0-9])
      (?<day>[0-3][0-9])
      (?<id>[0-7][0-9]{2})
      (?<check>[0-9])
      \z
    }x
    private_constant :MATCHER

    def birth_century = birth_date.strftime("%Y")[..1]
    def birth_year = birth_date.year

    def date(year, month, day)
      found_date = Date.new(year.to_i, month.to_i, day.to_i)
      found_date if found_date < Date.today
    rescue Date::Error
      nil
    end

    def checksum
      # 1. Multiply the values of each position by the corresponding weight:
      # 2. Add up the results of the above multiplications;
      sum = sum_weights([1, 2, 3, 4, 5, 6, 7, 8, 9, 1])

      # 3. Get modulo 11 of the result of the previous addition.
      remainder = sum % 11

      # 4. Check digit
      # a. If remainder is less than 10, the remainder is the check digit;
      return remainder if remainder < 10

      # b. If remainder is 10, use the following table instead of the previous
      # one:
      sum = sum_weights([3, 4, 5, 6, 7, 8, 9, 1, 2, 3])

      # If remainder is less than 10, the remainder is the check digit;
      remainder = sum % 11
      return remainder if remainder < 10

      # If remainder is 10, the check digit is 0.
      0
    end

    def sum_weights(weights)
      weights.each_with_index.sum do |char, index|
        char.to_i * tin[index].to_i
      end
    end
  end
end
