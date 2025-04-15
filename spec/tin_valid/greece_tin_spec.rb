# frozen_string_literal: true

RSpec.describe TinValid::GreeceTin do
  describe "#valid?" do
    valid_values = %w[
      999999999
    ]

    invalid_values = [
      "99999",
      "999999999999",
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
