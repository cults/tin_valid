# frozen_string_literal: true

RSpec.describe TinValid::GermanyTin do
  describe "#valid?" do
    valid_values = %w[
      5133081508159
      86095742719
      65929970489
    ]

    invalid_values = [
      "5133981508159",
      "86095744719",
      "86095777719",
      "86095742710",
      "65929970480",
      "0000000000000",
      "1234567890123",
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
