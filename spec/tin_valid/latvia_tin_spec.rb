# frozen_string_literal: true

RSpec.describe TinValid::LatviaTin do
  describe "#valid?" do
    valid_values = [
      ["01011012345", nil],
      ["01011012345", Date.new(1910, 1, 1)],
      ["32579461005", nil],
    ]

    invalid_values = [
      ["010110123459", nil],
      ["0101101234", nil],
      ["01011012345", Date.new(1910, 1, 9)],
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
        it do
          expect(described_class.new(tin:, birth_date:).valid?).to be(false)
        end
      end
    end
  end
end
