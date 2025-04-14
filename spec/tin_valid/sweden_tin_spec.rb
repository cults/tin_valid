# frozen_string_literal: true

RSpec.describe TinValid::SwedenTin do
  describe "#valid?" do
    valid_values = [
      ["640883-3231", nil],
      ["640823-3234", nil],
      ["640823-3234", Date.new(1964, 8, 23)],
    ]

    invalid_values = [
      ["640883-3239", nil],
      ["640823-3239", nil],
      ["640823-3234", Date.new(1964, 8, 29)],
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
