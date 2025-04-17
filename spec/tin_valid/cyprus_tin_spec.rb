# frozen_string_literal: true

RSpec.describe TinValid::CyprusTin do
  describe "#valid?" do
    # rubocop:disable Style/WordArray
    valid_values = [
      ["00123123T", nil],
      ["00123123T", "individual"],
      ["60123123H", nil],
      ["60123123H", "individual"],
      ["99652156X", nil],
      ["99652156X", "individual"],
    ]

    invalid_values = [
      ["00123129T", nil],
      ["00123129T", "individual"],
      ["60123129H", nil],
      ["60123129H", "individual"],
      ["99652159X", nil],
      ["99652159X", "individual"],
      ["000000000", nil],
      ["123456789", nil],
      [nil, nil],
      ["", nil],
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
