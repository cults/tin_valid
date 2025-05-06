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

```rb
# Check a tin by providing the country code as a lowercase string.
# Also accepts the following optional arguments:
# - birth_date as a Date
# - kind as one of the following strings: "individual", "company"
TinValid::Tin.new(country_code: "fr", tin: "…").valid?

# Austria
TinValid::AustriaTin.new(tin: "…").valid?

# Belgium
# - birth_date is optional
TinValid::BelgiumTin.new(tin: "…", birth_date: Date.new(…)).valid?

# Bulgaria
# - birth_date is optional
TinValid::BulgariaTin.new(tin: "…", birth_date: Date.new(…)).valid?

# Croatia
TinValid::CroatiaTin.new(tin: "…").valid?

# Cyprus
# Optional kind ("individual" or "company")
TinValid::CyprusTin.new(tin: "…", kind: "individual").valid?

# Czechia
# - birth_date is optional
TinValid::CzechiaTin.new(tin: "…", birth_date: Date.new(…)).valid?

# Denmark
# - birth_date is optional
TinValid::DenmarkTin.new(tin: "…", birth_date: Date.new(…)).valid?

# Estonia
# - birth_date is optional
TinValid::EstoniaTin.new(tin: "…", birth_date: Date.new(…)).valid?

# Finland
# - birth_date is optional
TinValid::FinlandTin.new(tin: "…", birth_date: Date.new(…)).valid?

# France
TinValid::FranceTin.new(tin: "…").valid?

# Germany
TinValid::GermanyTin.new(tin: "…").valid?

# Greece
TinValid::GreeceTin.new(tin: "…").valid?

# Hungary
TinValid::HungaryTin.new(tin: "…").valid?

# Ireland
TinValid::IrelandTin.new(tin: "…").valid?

# Italy
# - birth_date is optional
TinValid::ItalyTin.new(tin: "…", birth_date: Date.new(…)).valid?

# Latvia
# - birth_date is optional
TinValid::LatviaTin.new(tin: "…", birth_date: Date.new(…)).valid?

# Lithuania
# - birth_date is optional
TinValid::LithuaniaTin.new(tin: "…", birth_date: Date.new(…)).valid?

# Luxembourg
# - birth_date is optional
TinValid::LuxembourgTin.new(tin: "…", birth_date: Date.new(…)).valid?

# Malta
TinValid::MaltaTin.new(tin: "…").valid?

# Netherlands
TinValid::NetherlandsTin.new(tin: "…").valid?

# Poland
# - birth_date is optional
TinValid::PolandTin.new(tin: "…", birth_date: Date.new(…)).valid?

# Portugal
TinValid::PortugalTin.new(tin: "…").valid?

# Romania
# - birth_date is optional
TinValid::RomaniaTin.new(tin: "…", birth_date: Date.new(…)).valid?

# Slovakia
# - birth_date is optional
TinValid::SlovakiaTin.new(tin: "…", birth_date: Date.new(…)).valid?

# Slovenia
TinValid::SloveniaTin.new(tin: "…").valid?

# Spain
TinValid::SpainTin.new(tin: "…").valid?

# Sweden
# - birth_date is optional
TinValid::SwedenTin.new(tin: "…", birth_date: Date.new(…)).valid?

# United Kingdom
TinValid::UnitedKingdomTin.new(tin: "…").valid?
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
