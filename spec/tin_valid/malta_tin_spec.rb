# frozen_string_literal: true

RSpec.describe TinValid::MaltaTin do
  describe "#valid?" do
    valid_values = %w[
      1234567A
      113456789
    ]

    invalid_values = [
      "1234567",
      "1234567A9",
      "993456789",
      "00000000",
      "12345678",
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
