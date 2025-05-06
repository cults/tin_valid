# frozen_string_literal: true

RSpec.describe TinValid::LuxembourgTin do
  describe "#valid?" do
    valid_values = [
      ["1893120105732", nil],
      ["1893120105732", Date.new(1893, 12, 1)],
    ]

    invalid_values = [
      [nil, nil],
      ["", nil],
      ["1893120105792", nil],
      ["1893120105739", nil],
      ["18931201057329", nil],
      ["189312010573", nil],
      ["1893120105732", Date.new(1893, 12, 2)],
      ["0000000000000", nil],
      ["1234567891012", nil],
      ["2011032753396", nil],
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
