# frozen_string_literal: true

RSpec.describe TinValid::NetherlandsTin do
  describe "#valid?" do
    # rubocop:disable Style/WordArray
    valid_values = [
      ["174559434", "individual"],
      ["174559434", "company"],
      ["174559434", nil],
      ["174559439", "company"],
      ["174559439", nil],
    ]

    invalid_values = [
      ["1745594349", "individual"],
      ["1745594349", "company"],
      ["1745594349", nil],
      ["17455943", "individual"],
      ["17455943", "company"],
      ["17455943", nil],
      ["000000000", "individual"],
      ["000000000", "company"],
      ["000000000", nil],
      [nil, "individual"],
      [nil, "company"],
      [nil, nil],
      ["", "individual"],
      ["", "company"],
      ["", nil],
      ["123456789", "individual"],
      ["174559439", "individual"],
    ]
    # rubocop:enable Style/WordArray

    valid_values.each do |(tin, kind)|
      context(
        "with valid #{tin.inspect} and kind #{kind.inspect}",
      ) do
        it { expect(described_class.new(tin:, kind:).valid?).to be(true) }
      end
    end

    invalid_values.each do |(tin, kind)|
      context(
        "with invalid #{tin.inspect} and kind #{kind.inspect}",
      ) do
        it { expect(described_class.new(tin:, kind:).valid?).to be(false) }
      end
    end
  end
end
