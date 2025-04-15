# frozen_string_literal: true

RSpec.describe TinValid::AustriaTin do
  describe "#valid?" do
    valid_values = [
      "931736581",
      "93-173/6581 ",
      "163308331",
    ]

    invalid_values = [
      "9317365819",
      "93173658",
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

  describe "#normalized" do
    let(:tin) { described_class.new(tin: "93-173/6581  ") }

    it { expect(tin.normalized).to eq("931736581") }
  end
end
