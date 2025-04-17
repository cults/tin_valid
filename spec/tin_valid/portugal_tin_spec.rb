# frozen_string_literal: true

RSpec.describe TinValid::PortugalTin do
  describe "#valid?" do
    valid_values = %w[
      299999998
    ]

    invalid_values = [
      "299999999",
      "29999999",
      "2999999989",
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
