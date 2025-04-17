# frozen_string_literal: true

RSpec.describe TinValid::SpainTin do
  describe "#valid?" do
    valid_values = %w[
      54237A
      00054237A
      X1234567L
      Z1234567R
      M2812345C
    ]

    invalid_values = [
      "150125579",
      "1501255",
      "15012559",
      "05012557",
      "X1234567E",
      "X1234567",
      "Z1234567B",
      "M2812345Z",
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
