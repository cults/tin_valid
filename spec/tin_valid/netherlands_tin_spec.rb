# frozen_string_literal: true

RSpec.describe TinValid::NetherlandsTin do
  describe "#valid?" do
    valid_values = %w[
      174559434
    ]

    invalid_values = [
      "1745594349",
      "17455943",
      "174559439",
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
