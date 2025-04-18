# frozen_string_literal: true

RSpec.describe TinValid::PolandTin do
  describe "#valid?" do
    valid_values = [
      ["2234567895", nil],
      ["02070803628", Date.new(1902, 7, 8)],
    ]

    invalid_values = [
      ["223456789", nil],
      ["22345678959", nil],
      ["2234567899", nil],
      ["02070803628", Date.new(1902, 7, 9)],
      ["0000000000", nil],
      ["00000000000", nil],
      ["1234567890", nil],
      ["12345678901", nil],
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
