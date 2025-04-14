# frozen_string_literal: true

module TinValid
  class DenmarkTin < Data.define(:tin, :birth_date)
    def initialize(tin:, birth_date: nil)
      super
    end

    def valid?
      match = MATCHER.match(tin)
      return false unless match

      if birth_date
        year = "#{birth_century}#{match[:year]}"
        return false if birth_date != date(year, match[:month], match[:day])

        return false unless check_serial(match[:serial], match[:year])
      end

      match[:check].to_i == checksum
    end

    private

    MATCHER = %r{
      \A
      (?<day>[0-3][0-9])
      (?<month>[0-1][0-9])
      (?<year>[0-9]{2})
      (?<serial>
        [0-9]{3}
        (?<check>[0-9])
      )
      \z
    }x
    private_constant :MATCHER

    def birth_century = birth_date.strftime("%Y")[..1]
    def birth_year = birth_date.year

    def date(year, month, day)
      Date.new(year.to_i, month.to_i, day.to_i)
    rescue Date::Error
      nil
    end

    def checksum
      # 1. Multiply the values of each position by the corresponding weight:
      weights =
        [4, 3, 2, 7, 6, 5, 4, 3, 2]
          .each_with_index
          .map { |char, index| char.to_i * tin[index].to_i }

      # 2. Add up the results of the above multiplications;
      sum = weights.sum

      # 3. Get modulo 11 of the result of the previous addition. The remainder
      # must not be 1;
      remainder = sum % 11

      return if remainder == 1

      # 4. Check digit = 11 – remainder, or check digit = 0 if the result of the
      # modulo operation of the third step is 0.
      remainder == 0 ? 0 : 11 - remainder
    end

    # rubocop:disable Metrics/CyclomaticComplexity
    # rubocop:disable Metrics/MethodLength
    # rubocop:disable Metrics/PerceivedComplexity
    def check_serial(serial, year)
      case serial.to_i
      in 1..3999
        (1900..1999).cover?(birth_year)
      in 4000..4999, 9000..9999
        case year.to_i
        in 0..36 then (2000..2036).cover?(birth_year)
        in 36..99 then (1937..1999).cover?(birth_year)
        end
      in 5000..8999
        case year.to_i
        in 0..36 then (2000..2036).cover?(birth_year)
        in 37..57 then false
        in 58..99 then (1858..1899).cover?(birth_year)
        end
      end
    end
    # rubocop:enable Metrics/CyclomaticComplexity
    # rubocop:enable Metrics/MethodLength
    # rubocop:enable Metrics/PerceivedComplexity
  end
end
