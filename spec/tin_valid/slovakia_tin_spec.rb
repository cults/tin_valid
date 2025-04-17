# frozen_string_literal: true

RSpec.describe TinValid::SlovakiaTin do
  describe "#valid?" do
    valid_values = [
      ["7711167420", nil],
      ["7711167420", Date.new(1977, 11, 16)],
      ["7761167420", Date.new(1977, 11, 16)],
      ["771116/7420", nil],
      ["771116/7420", Date.new(1977, 11, 16)],
      ["281203054", nil],
      ["281203/054", nil],
      ["286203054", nil],
      ["9234567890", nil],
      ["9234567890", Date.new(1900, 1, 1)],
    ]

    invalid_values = [
      ["77111674209", nil],
      ["287203054", nil],
      ["771116742", nil],
      ["771203054", nil],
      ["28120305999", nil],
      ["771116/742", nil],
      ["281203054", Date.new(1928, 12, 4)],
      ["12345678901", nil],
      ["0000000000", nil],
      ["000000000", nil],
      ["1234567890", nil],
      ["123456789", nil],
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

  describe "#normalized" do
    it do
      expect(described_class.new(tin: "771116/742").normalized)
        .to eq("771116742")
    end
  end
end
