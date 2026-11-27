# frozen_string_literal: true

RSpec.describe TinValid::HungaryTin do
  describe "#valid?" do
    valid_values = [
      ["8071592153", nil],
      ["8071592153", "individual"],
      ["HU25099999", nil],
      ["HU25099999", "company"],
      ["25099999-2-14", nil],
      ["25099999-2-14", "company"],
    ]

    invalid_values = [
      ["8071592", nil],
      ["8071592153999", nil],
      ["8071592159", nil],
      ["8071592153", "company"],
      ["25099999-2-14", "individual"],
      ["HU25099999", "individual"],
      ["0000000000", nil],
      ["1234567891", nil],
      [nil, nil],
      ["", nil],
    ]

    valid_values.each do |tin, kind|
      context "with valid #{tin.inspect} and kind #{kind.inspect}" do
        it { expect(described_class.new(tin:, kind:).valid?).to be(true) }
      end
    end

    invalid_values.each do |tin, kind|
      context "with invalid #{tin.inspect} and kind #{kind.inspect}" do
        it { expect(described_class.new(tin:, kind:).valid?).to be(false) }
      end
    end
  end
end
