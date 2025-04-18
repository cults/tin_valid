# frozen_string_literal: true

RSpec.describe TinValid::DenmarkTin do
  describe "#valid?" do
    valid_values = [
      ["0101111113", nil],
      ["0101111113", Date.new(1911, 1, 1)],
    ]

    invalid_values = [
      ["0101111119", nil],
      ["0101111113", Date.new(1911, 1, 9)],
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
