# frozen_string_literal: true

RSpec.describe TinValid::CroatiaTin do
  describe "#valid?" do
    valid_values = [
      "94577403194",
    ]

    invalid_values = [
      "945774031941",
      "94577403195",
      "94577",
      "00000000000",
      "12345678901",
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
