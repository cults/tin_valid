# frozen_string_literal: true

RSpec.describe TinValid::IrelandTin do
  describe "#valid?" do
    valid_values = %w[
      1234567T
      1234567TW
      1234577W
      1234577WW
      1234577IA
    ]

    invalid_values = [
      "1234567",
      "1234567A",
      "1234567TA",
      "1234577A",
      "1234572WW",
      "1234577AA",
      nil,
      "",
    ]

    valid_values.each do |tin|
      context "with valid #{tin.inspect}" do
        it { expect(described_class.new(tin).valid?).to be(true) }
      end
    end

    invalid_values.each do |tin|
      context "with invalid #{tin.inspect}" do
        it { expect(described_class.new(tin).valid?).to be(false) }
      end
    end
  end
end
