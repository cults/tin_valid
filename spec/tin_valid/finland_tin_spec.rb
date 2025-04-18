# frozen_string_literal: true

RSpec.describe TinValid::FinlandTin do
  describe "#valid?" do
    valid_values = [
      ["131052-308T", nil],
      ["131052-308T", Date.new(1952, 10, 13)],
    ]

    invalid_values = [
      ["131052-308E", nil],
      ["931052-308T", nil],
      ["131052-308T", Date.new(1952, 10, 14)],
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
