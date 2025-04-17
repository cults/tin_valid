# frozen_string_literal: true

RSpec.describe TinValid::UnitedKingdomTin do
  describe "#valid?" do
    valid_values = %w[
      1234567890
      AA123456A
      AA123456
    ]

    invalid_values = [
      "12345678909",
      "123456789",
      "DA123456A",
      "AF123456A",
      "GB123456A",
      "NK123456A",
      "TN123456A",
      "AA123456E",
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
