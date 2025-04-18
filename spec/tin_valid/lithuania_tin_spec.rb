# frozen_string_literal: true

RSpec.describe TinValid::LithuaniaTin do
  describe "#valid?" do
    valid_values = [
      ["10101010005", nil],
      ["10101010005", Date.new(2001, 1, 1)],
    ]

    invalid_values = [
      ["101010100059", nil],
      ["1010101000", nil],
      ["10101010005", Date.new(2001, 1, 2)],
      ["00000000000", nil],
      ["12345678910", nil],
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
        it {
          expect(described_class.new(tin:, birth_date:).valid?).to be(false)
        }
      end
    end
  end
end
