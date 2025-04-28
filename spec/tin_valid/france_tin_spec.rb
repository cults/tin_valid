# frozen_string_literal: true

RSpec.describe TinValid::FranceTin do
  describe "#valid?" do
    valid_values = %w[
      3023217600053
      302321760
    ]

    invalid_values = [
      "3023217600059",
      "30232176000539",
      "302321760005",
      "0000000000000",
      "1234567890123",
      "000000000",
      "123456789",
      nil,
      "",
    ]

    valid_values.each do |tin|
      context "with valid #{tin.inspect}" do
        it { expect(described_class.new(tin:).valid?).to be(true) }
      end
    end

    invalid_values.each do |tin|
      context "with invalid #{tin.inspect}" do
        it { expect(described_class.new(tin:).valid?).to be(false) }
      end
    end
  end
end
