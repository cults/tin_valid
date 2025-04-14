# frozen_string_literal: true

RSpec.describe TinValid::ItalyTin do
  describe "#valid?" do
    valid_values = [
      ["DMLPRY77D15H501F", nil],
    ]

    invalid_values = [
      ["DMLPRY77D15H501", nil],
      ["DMLPRY77D15H501F9", nil],
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
