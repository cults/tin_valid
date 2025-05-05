# frozen_string_literal: true

RSpec.describe TinValid::FranceTin do
  describe "#valid?" do
    valid_values = %w[
      3023217600053
      552100554
      732829320
      73282932000074
    ]

    invalid_values = [
      "3023217600059",
      "30232176000539",
      "302321760005",
      "0000000000000",
      "1234567890123",
      "000000000",
      "123456789",
      "00000000000000",
      "12345678912345",
      "73282932000075",
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

  describe "#siren?" do
    valid_values = %w[
      552100554
      732829320
    ]

    invalid_values = [
      "000000000",
      "123456789",
      "3023217600053",
      "73282932000074",
      nil,
      "",
    ]

    valid_values.each do |tin|
      context "with valid #{tin.inspect}" do
        it { expect(described_class.new(tin:).siren?).to be(true) }
      end
    end

    invalid_values.each do |tin|
      context "with invalid #{tin.inspect}" do
        it { expect(described_class.new(tin:).siren?).to be(false) }
      end
    end
  end

  describe "#siret?" do
    valid_values = %w[
      73282932000074
    ]

    invalid_values = [
      "00000000000000",
      "12345678912345",
      "73282932000075",
      "3023217600053",
      "302321760",
      "552100554",
      "732829320",
      nil,
      "",
    ]

    valid_values.each do |tin|
      context "with valid #{tin.inspect}" do
        it { expect(described_class.new(tin:).siret?).to be(true) }
      end
    end

    invalid_values.each do |tin|
      context "with invalid #{tin.inspect}" do
        it { expect(described_class.new(tin:).siret?).to be(false) }
      end
    end
  end
end
