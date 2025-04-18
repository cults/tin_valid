# frozen_string_literal: true

module TinValid
  class BulgariaTin < Data.define(:tin, :birth_date)
    def initialize(tin:, birth_date: nil)
      super
    end

    def valid?
      match = MATCHER.match(tin)
      return false unless match

      year = match[:year]
      month = match[:month]
      day = match[:day]
      return false unless accepted_date?(year, month, day)

      tin[-1].to_i == check
    end

    private

    MATCHER = %r{
      \A
      (?<year>[0-9]{2})
      (?<month>[0-5][0-9])
      (?<day>[0-3][0-9])
      [0-9]{4}
      \z
    }x
    private_constant :MATCHER

    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/MethodLength
    def accepted_date?(year, month, day)
      month = month.to_i
      day = day.to_i

      if birth_date.nil?
        past_date?("18#{year}", month - 20, day) ||
          past_date?("19#{year}", month, day) ||
          past_date?("20#{year}", month - 40, day)
      elsif birth_year < 1900
        birth_date == date("18#{year}", month - 20, day)
      elsif birth_year < 2000
        birth_date == date("19#{year}", month, day)
      else
        birth_date == date("20#{year}", month - 40, day)
      end
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/MethodLength

    def birth_year = birth_date.year

    def past_date?(year, month, day)
      found_date = date(year, month, day)
      found_date && found_date < Date.today
    end

    def date(year, month, day)
      found_date = Date.new(year.to_i, month.to_i, day.to_i)
      found_date if found_date < Date.today
    rescue Date::Error
      nil
    end

    def check
      weights = [2, 4, 8, 5, 10, 9, 7, 3, 6]

      # 1. Multiply the values of each position by the corresponding weight
      values_by_weight =
        tin[..-2]
          .chars
          .zip(weights)
          .map { |char, weight| char.to_i * weight }

      # 2. Add up the results of the above multiplications
      sum = values_by_weight.sum

      # 3. Get modulo 11 of the result of the previous addition
      remainder = sum % 11

      # 4. Check digit = remainder if remainder < 10
      # Check digit = 0 if remainder = 10
      remainder < 10 ? remainder : 0
    end
  end
end
