# frozen_string_literal: true

RSpec.describe TinValid::BulgariaTin do
  describe "#valid?" do
    valid_values = [
      ["7501010010", nil],
      ["7501010010", Date.new(1975, 1, 1)],
    ]

    invalid_values = [
      ["750101001", nil],
      ["75010100101", nil],
      ["7501010019", nil],
      ["7501010010", Date.new(1975, 1, 2)],
      ["0000000000", nil],
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
