# frozen_string_literal: true

RSpec.describe TinValid::HungaryTin do
  describe "#valid?" do
    valid_values = %w[
      8071592153
    ]

    invalid_values = [
      "8071592",
      "8071592153999",
      "8071592159",
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
