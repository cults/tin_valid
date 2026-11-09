# frozen_string_literal: true

RSpec.describe TinValid::Tin do
  describe "#valid?" do
    valid_values = [
      # country
      # |    tin                 birth_date              kind
      # |    |                   |                       |
      ["at", "931736581",        nil,                    nil],
      ["be", "00012511119",      Date.new(1900, 1, 25),  nil],
      ["bg", "7501010010",       Date.new(1975, 1, 1),   nil],
      ["cy", "99652156X",        nil,                    "individual"],
      ["cz", "420901999",        Date.new(1942, 9, 1),   nil],
      ["de", "5133081508159",    nil,                    nil],
      ["dk", "0101111113",       Date.new(1911, 1, 1),   nil],
      ["ee", "37102250382",      Date.new(1971, 2, 25),  nil],
      ["es", "54237A",           nil,                    nil],
      ["fi", "131052-308T",      Date.new(1952, 10, 13), nil],
      ["fr", "3023217600053",    nil,                    nil],
      ["gb", "9234567890",       nil,                    nil],
      ["gr", "999999999",        nil,                    nil],
      ["hr", "94577403194",      nil,                    nil],
      ["hu", "8071592153",       nil,                    nil],
      ["ie", "1234567T",         nil,                    nil],
      ["it", "DMLPRY77D15H501F", Date.new(1977, 4, 15),  nil],
      ["lt", "10101010005",      Date.new(2001, 1, 1),   nil],
      ["lu", "1893120105732",    Date.new(1893, 12, 1),  nil],
      ["lv", "01011012345",      Date.new(1910, 1, 1),   nil],
      ["mt", "1234567A",         nil,                    nil],
      ["nl", "174559434",        nil,                    nil],
      ["pl", "02070803628",      Date.new(1902, 7, 8),   nil],
      ["pt", "299999998",        nil,                    nil],
      ["ro", "8001011234567",    Date.new(2000, 10, 11), nil],
      ["se", "640823-3234",      Date.new(1964, 8, 23),  nil],
      ["si", "15012557",         nil,                    nil],
      ["sk", "7711167420",       Date.new(1977, 11, 16), nil],
    ]

    invalid_values = [
      # country     birth_date
      # |    tin    |    kind
      # |    |      |    |
      ["at", "123", nil, nil],
      ["at", nil,   nil, nil],
      ["at", "",    nil, nil],
    ]

    valid_values.each do |(country_code, tin, birth_date, kind)|
      context(
        "with valid #{tin.inspect} for country #{country_code.inspect}," \
        "birth date #{birth_date.inspect}, and kind #{kind.inspect}",
      ) do
        it do
          instance = described_class.new(
            country_code:,
            tin:,
            birth_date:,
            kind:,
          )
          expect(instance.valid?).to be(true)
        end
      end
    end

    invalid_values.each do |(country_code, tin, birth_date, kind)|
      context(
        "with valid #{tin.inspect} for country #{country_code.inspect}," \
        "birth date #{birth_date.inspect}, and kind #{kind.inspect}",
      ) do
        it do
          instance = described_class.new(
            country_code:,
            tin:,
            birth_date:,
            kind:,
          )
          expect(instance.valid?).to be(false)
        end
      end
    end
  end

  describe "#normalized" do
    values = [
      # country
      # |    tin
      # |    |                   expected
      # |    |                   |
      ["at", "931736581",        "931736581"],
      ["at", "93-173/6581",      "931736581"],
      ["be", "00012511148",      "00012511148"],
      ["be", "00.01.25-111.48",  "00012511148"],
      ["bg", "7501010010",       "7501010010"],
      ["cy", "99652156X",        "99652156X"],
      ["cz", "420901999",        "420901999"],
      ["cz", "CZ420901999",      "420901999"],
      ["de", "5133081508159",    "5133081508159"],
      ["dk", "0101111113",       "0101111113"],
      ["dk", "010111-1113",      "0101111113"],
      ["ee", "37102250382",      "37102250382"],
      ["es", "54237A",           "54237A"],
      ["fi", "131052-308T",      "131052-308T"],
      ["fr", "3023217600053",    "3023217600053"],
      ["gb", "9234567890",       "9234567890"],
      ["gr", "999999999",        "999999999"],
      ["hr", "94577403194",      "94577403194"],
      ["hu", "8071592153",       "8071592153"],
      ["ie", "1234567T",         "1234567T"],
      ["it", "DMLPRY77D15H501F", "DMLPRY77D15H501F"],
      ["lt", "10101010005",      "10101010005"],
      ["lu", "1893120105732",    "1893120105732"],
      ["lv", "01011012345",      "01011012345"],
      ["mt", "1234567A",         "1234567A"],
      ["nl", "174559434",        "174559434"],
      ["pl", "02070803628",      "02070803628"],
      ["pt", "299999998",        "299999998"],
      ["ro", "8001011234567",    "8001011234567"],
      ["se", "640823-3234",      "640823-3234"],
      ["si", "15012557",         "15012557"],
      ["sk", "7711167420",       "7711167420"],
      ["sk", "771116/7420",      "7711167420"],
    ]

    values.each do |(country_code, tin, expected)|
      context "with #{tin.inspect} for country #{country_code.inspect}" do
        it do
          instance = described_class.new(country_code:, tin:)
          expect(instance.normalized).to eq(expected)
        end
      end
    end
  end
end
