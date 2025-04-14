# frozen_string_literal: true

module TinValid
  class GermanyTin < Data.define(:tin)
    def valid?
      valid_v1? || valid_v2?
    end

    private

    def valid_v1?
      # 1. 13 characters
      # 2. Only digits
      # 3. C5 is a 0
      /\A[0-9]{4}0[0-9]{8}\z/.match?(tin)
    end

    # rubocop:disable Metrics/AbcSize
    def valid_v2?
      # C1: Must never be 0.
      return false unless /\A[1-9][0-9]{10}\z/.match?(tin)

      # C1-C10: One and only one mandatory duplicate or triple value:
      # - One of the first ten digits is used twice (the recurrent digits do
      #   not have to be located at subsequent positions but they can be);
      # - One of the first ten digits is used tree times (only two recurrent
      #   digits are allowed to be one after another).
      consecutive_chars =
        tin[..-2]
          .chars
          .group_by(&:itself)
          .select { |_, chars| chars.size > 1 }

      return false if consecutive_chars.size != 1
      return false if consecutive_chars.first.last.size > 3

      tin[-1].to_i == check_v2
    end
    # rubocop:enable Metrics/AbcSize

    def check_v2
      # 1. Initialize the variable X to 10.
      y = tin[..-2].chars.inject(10) do |x, char|
        # 2. Take C1 + X modulo 10. If result is 0, result is 10;
        result = (char.to_i + x) % 10
        result = 10 if result == 0

        # 3. Multiply the result by 2;
        result *= 2

        # 4. Take modulo 11 of the result. Update the value of variable X with the result of this operation;
        x = result % 11

        # 5. Take C2 + X modulo 10. If result is 0, result is 10;
        # 6. Multiply the result by 2;
        # 7. Take modulo 11 of the result. Update the value of variable X with the result of this operation;
        # 8. Apply steps 5, 6 and 7 in an analogue way for digits C3 to C10. Consider that last value called Y;
        x
      end

      # 9. 11 - Y = check digit. If check digit = 10, replace it by 0.
      check = 11 - y
      check == 10 ? 0 : check
    end
  end
end
