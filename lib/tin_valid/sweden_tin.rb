# frozen_string_literal: true

module TinValid
  class SwedenTin
    include TinValid::Helpers

    def initialize(tin:, birth_date: nil)
      @tin = tin
      @birth_date = birth_date
    end

    attr_reader :tin, :birth_date

    def valid?
      VERSIONS.any? do |matcher|
        match = matcher.match(tin)
        next false unless match

        year = match[:year]
        month = match[:month]
        day = match[:day]
        next false unless date_valid?(year, month, day)

        id = match[:id]
        match[:check].to_i == checksum("#{year[..2]}#{month}#{day}#{id}")
      end
    end

    private

    VERSIONS = [
      %r{
        \A
        (?<year>[0-9]{2})
        (?<month>[0-1][0-9])
        (?<day>[0-3][0-9])
        -
        (?<id>[0-9]{3})
        (?<check>[0-9])
        \z
      }x,
      %r{
        \A
        (?<year>[0-9]{2})
        (?<month>[0-1][0-9])
        (?<day>[6-9][0-9])
        -
        (?<id>[0-9]{3})
        (?<check>[0-9])
        \z
      }x,
      %r{
        \A
        (?<year>1[89][0-9]{2})
        (?<month>[0-1][0-9])
        (?<day>[0-3][0-9])
        (?<id>[0-9]{3})
        (?<check>[0-9])
        \z
      }x,
      %r{
        \A
        (?<year>(?:18|19|20)[0-9]{2})
        (?<month>[0-1][0-9])
        (?<day>[6-9][0-9])
        (?<id>[0-9]{3})
        (?<check>[0-9])
        \z
      }x,
    ].freeze
    private_constant :VERSIONS

    def checksum(numbers)
      # 1. Multiply the values of each position by the corresponding weight:
      # - C1: 2
      # - C2: 1
      # - C3: 2
      # - C4: 1
      # - C5: 2
      # - C6: 1
      # - C7: 2
      # - C8: 1
      # - C9: 2
      values_by_weight =
        numbers
          .chars
          .each_with_index
          .map { |n, i| n.to_i * (i.even? ? 2 : 1) }

      # 2. Add up the results of the above multiplications. NB: 12 is regarded
      # as 1 + 2;
      sum = values_by_weight.join.chars.sum(&:to_i)

      # 3. The unit digit in the sum of the digits is subtracted from 10 and the
      # result is the check digit. If the resulting number is 10, the check
      # digit is 0.
      last_digit = sum % 10
      last_digit == 0 ? 0 : 10 - last_digit
    end

    def date_valid?(year, month, day)
      day = day.to_i
      day -= 60 if day > 60

      if birth_date
        year = "#{birth_date.strftime('%Y')[..1]}#{year}" if year.size == 2
        birth_date == date(year, month, day)
      else
        date(year, month, day) ||
          date("19#{year}", month, day) ||
          date("20#{year}", month, day)
      end
    end
  end
end
