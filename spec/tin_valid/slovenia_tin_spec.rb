# frozen_string_literal: true

RSpec.describe TinValid::SloveniaTin do
  describe "#valid?" do
    valid_values = %w[
      15012557
    ]

    invalid_values = [
      "150125579",
      "1501255",
      "15012559",
      "05012557",
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
