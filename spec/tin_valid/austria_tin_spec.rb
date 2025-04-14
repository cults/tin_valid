# frozen_string_literal: true

RSpec.describe TinValid::AustriaTin do
  describe "#valid?" do
    valid_values = [
      "999999999",
    ]

    invalid_values = [
      "9999999999999990",
      "9999",
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
