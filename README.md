# TinValid 🇪🇺

Validate Tax Identification Numbers (TINs) for the following European countries:

- Austria 🇦🇹
- Belgium 🇧🇪
- Bulgaria 🇧🇬
- Croatia 🇭🇷
- Cyprus 🇨🇾
- Czechia 🇨🇿
- Denmark 🇩🇰
- Estonia 🇪🇪
- Finland 🇫🇮
- France 🇫🇷
- Germany 🇩🇪
- Greece 🇬🇷
- Hungary 🇭🇺
- Ireland 🇮🇪
- Italy 🇮🇹
- Latvia 🇱🇻
- Lithuania 🇱🇹
- Luxembourg 🇱🇺
- Malta 🇲🇹
- Netherlands 🇳🇱
- Poland 🇵🇱
- Portugal 🇵🇹
- Romania 🇷🇴
- Slovakia 🇸🇰
- Slovenia 🇸🇮
- Spain 🇪🇸
- Sweden 🇸🇪
- United Kingdom 🇬🇧

See also the
[TIN specifications](https://ec.europa.eu/taxation_customs/tin/#/check-tin)
and the
[descriptions of the structure](https://taxation-customs.ec.europa.eu/online-services/online-services-and-databases-taxation/taxpayer-identification-number-tin_en)
provided by the European Union.

## Installation

Add the gem to your application’s Gemfile by executing:

```bash
bundle add tin_valid
```

If bundler is not being used to manage dependencies, install the gem by
executing:

```bash
gem install tin_valid
```

## Usage

Check a TIN by providing the country code as a lowercase string.

Also accepts the following optional arguments:

- `birth_date`: Date
- `kind`: `"individual"` or `"company"`

```rb
TinValid::Tin.new(country_code: "fr", tin: "3023217600053").valid?
```

You can also call countries individually:

### Austria (at)

```rb
TinValid::AustriaTin.new(
  tin: "931736581",
).valid?
```

### Belgium (be)

`birth_date` is optional

```rb
TinValid::BelgiumTin.new(
  tin: "00012511119",
  birth_date: Date.new(1900, 1, 25),
).valid?
```

### Bulgaria (bg)

`birth_date` is optional

```rb
TinValid::BulgariaTin.new(
  tin: "7501010010",
  birth_date: Date.new(1975, 1, 1),
).valid?
```

### Croatia (hr)

```rb
TinValid::CroatiaTin.new(
  tin: "94577403194",
).valid?
```

### Cyprus (cy)

`kind` is optional and can be `"individual"` or `"company"`

```rb
TinValid::CyprusTin.new(
  tin: "00123123T",
  kind: "individual",
).valid?
```

### Czechia (cz)

`birth_date` is optional

```rb
TinValid::CzechiaTin.new(
  tin: "420901999",
  birth_date: Date.new(1942, 9, 1),
).valid?
```

### Denmark (dk)

`birth_date` is optional

```rb
TinValid::DenmarkTin.new(
  tin: "0101111113",
  birth_date: Date.new(1911, 1, 1),
).valid?
```

### Estonia (ee)

`birth_date` is optional

```rb
TinValid::EstoniaTin.new(
  tin: "37102250382",
  birth_date: Date.new(1971, 2, 25),
).valid?
```

### Finland (fi)

`birth_date` is optional

```rb
TinValid::FinlandTin.new(
  tin: "131052-308T",
  birth_date: Date.new(1952, 10, 13),
).valid?
```

### France (fr)

```rb
TinValid::FranceTin.new(tin: "3023217600053").valid?
TinValid::FranceTin.new(tin: "732829320").siren?
TinValid::FranceTin.new(tin: "73282932000074").siret?
```

### Germany (de)

```rb
TinValid::GermanyTin.new(tin: "5133081508159").valid?
```

### Greece (gr)

```rb
TinValid::GreeceTin.new(tin: "999999999").valid?
```

### Hungary (hu)

```rb
TinValid::HungaryTin.new(tin: "8071592153").valid?
```

### Ireland (ie)

```rb
TinValid::IrelandTin.new(tin: "1234567T").valid?
```

### Italy (it)

`birth_date` is optional

```rb
TinValid::ItalyTin.new(
  tin: "DMLPRY77D15H501F",
  birth_date: Date.new(1977, 4, 15),
).valid?
```

### Latvia (lv)

`birth_date` is optional

```rb
TinValid::LatviaTin.new(
  tin: "01011012345",
  Date.new(1910, 1, 1),
).valid?
```

### Lithuania (lt)

`birth_date` is optional

```rb
TinValid::LithuaniaTin.new(
  tin: "10101010005",
  birth_date: Date.new(2001, 1, 1),
).valid?
```

### Luxembourg (lu)

`birth_date` is optional

```rb
TinValid::LuxembourgTin.new(
  tin: "1893120105732",
  birth_date: Date.new(1893, 12, 1),
).valid?
```

### Malta (mt)

```rb
TinValid::MaltaTin.new(tin: "1234567A").valid?
```

### Netherlands (nl)

```rb
TinValid::NetherlandsTin.new(tin: "174559434").valid?
```

### Poland (pl)

`birth_date` is optional

```rb
TinValid::PolandTin.new(
  tin: "02070803628",
  birth_date: Date.new(1902, 7, 8),
).valid?
```

### Portugal (pt)

```rb
TinValid::PortugalTin.new(tin: "299999998").valid?
```

### Romania (ro)

`birth_date` is optional

```rb
TinValid::RomaniaTin.new(
  tin: "8001011234567",
  birth_date: Date.new(2000, 10, 11),
).valid?
```

### Slovakia (sk)

`birth_date` is optional

```rb
TinValid::SlovakiaTin.new(
  tin: "7711167420",
  Date.new(1977, 11, 16),
).valid?
```

### Slovenia (si)

```rb
TinValid::SloveniaTin.new(
  tin: "7711167420",
  Date.new(1977, 11, 16),
).valid?
```

### Spain (es)

```rb
TinValid::SpainTin.new(tin: "54237A").valid?
```

### Sweden (se)

`birth_date` is optional

```rb
TinValid::SwedenTin.new(
  tin: "640823-3234",
  birth_date: Date.new(1964, 8, 23),
).valid?
```

### United Kingdom (gb)

```rb
TinValid::UnitedKingdomTin.new(tin: "9234567890").valid?
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`bin/rspec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bin/rake install`. To
release a new version, update the version number in `version.rb`, call `bundle`
and then create a commit using:

```sh
git commit -m "v`ruby -r./lib/tin_valid/version <<< 'puts TinValid::VERSION + \" 🎉\"'`"
```

Finally, call `bin/rake release`, which will create a git tag for the version,
push git commits and the created tag, and add the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/cults/tin_valid. This project is intended to be a safe,
welcoming space for collaboration, and contributors are expected to adhere to
the
[code of conduct](https://github.com/cults/tin_valid/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the
[MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the TinValid project's codebases, issue trackers, chat
rooms and mailing lists is expected to follow the
[code of conduct](https://github.com/cults/tin_valid/blob/main/CODE_OF_CONDUCT.md).
