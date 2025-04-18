# frozen_string_literal: true

RSpec.describe TinValid::EstoniaTin do
  describe "#valid?" do
    valid_values = [
      ["37102250382", nil],
      ["37102250382", Date.new(1971, 2, 25)],
      ["32708101201", nil],
      ["32708101201", Date.new(1927, 8, 10)],
      ["46304280206", nil],
      ["46304280206", Date.new(1963, 4, 28)],
    ]

    invalid_values = [
      ["3710225038", nil],
      ["371022503890", nil],
      ["37102250389", nil],
      ["37102250382", Date.new(1971, 9, 25)],
      ["32708101209", nil],
      ["32708101201", Date.new(1927, 8, 19)],
      ["46304280209", nil],
      ["46304280206", Date.new(1963, 4, 29)],
      ["00000000000", nil],
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
