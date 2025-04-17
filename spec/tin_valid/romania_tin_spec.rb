# frozen_string_literal: true

RSpec.describe TinValid::RomaniaTin do
  describe "#valid?" do
    valid_values = [
      ["8001011234567", nil],
      ["8001011234567", nil],
      ["900012345678", nil],
    ]

    invalid_values = [
      ["80010112345679", nil],
      ["80010112345", nil],
      ["920012345678", nil],
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
