# frozen_string_literal: true

RSpec.describe TinValid::BelgiumTin do
  describe "#valid?" do
    valid_values = [
      ["00012511119", nil],
      ["00012511148", nil],
      ["00012511119", Date.new(1900, 1, 25)],
      ["00012511148", Date.new(2000, 1, 25)],
    ]

    invalid_values = [
      ["00012511110", nil],
      ["00012511149", nil],
      ["99888899999", nil],
      ["00012511119", Date.new(1900, 1, 26)],
      ["00012511148", Date.new(2000, 1, 26)],
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
