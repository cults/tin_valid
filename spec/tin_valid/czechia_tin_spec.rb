# frozen_string_literal: true

RSpec.describe TinValid::CzechiaTin do
  describe "#valid?" do
    valid_values = [
      ["420901999", nil],
      ["420901/999", nil],
      ["0009019999", nil],
      ["000901/9999", nil],
      ["420901999", Date.new(1942, 9, 1)],
      ["420901/999", Date.new(1942, 9, 1)],
    ]

    invalid_values = [
      ["420901999999", nil],
      ["4209019999", Date.new(1942, 9, 1)],
      ["000000000", nil],
      ["0000000000", nil],
      ["123456789", nil],
      ["1234567890", nil],
      [nil, nil],
      ["", nil],
    ]

    valid_values.each do |(tin, birth_date)|
      context(
        "with valid #{tin.inspect} and birth date #{birth_date.inspect}",
      ) do
        it { expect(described_class.new(tin:, birth_date:).valid?).to be(true) }
      end
    end

    invalid_values.each do |(tin, birth_date)|
      context(
        "with invalid #{tin.inspect} and birth date #{birth_date.inspect}",
      ) do
        it do
          expect(described_class.new(tin:, birth_date:).valid?).to be(false)
        end
      end
    end
  end
end
