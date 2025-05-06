# frozen_string_literal: true

RSpec.describe TinValid::Tin do
  describe "#valid?" do
    valid_values = [
      ["at", "931736581", nil],
    ]

    invalid_values = [
      ["at", "93173658", nil],
      ["at", nil, nil],
      ["at", "", nil],
    ]

    valid_values.each do |(country_code, tin, birth_date)|
      context(
        "with valid #{tin.inspect} for country #{country_code.inspect} " \
        "and birth date #{birth_date.inspect}",
      ) do
        it do
          expect(described_class.new(country_code:, tin:, birth_date:).valid?)
            .to be(true)
        end
      end
    end

    invalid_values.each do |(country_code, tin, birth_date)|
      context(
        "with invalid #{tin.inspect} for country #{country_code.inspect} " \
        "and birth date #{birth_date.inspect}",
      ) do
        it do
          expect(described_class.new(country_code:, tin:, birth_date:).valid?)
            .to be(false)
        end
      end
    end
  end
end
