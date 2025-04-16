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
- Germany 🇩🇪
- Greece 🇬🇷
- Hungary 🇭🇺
- Ireland 🇮🇪
- Latvia 🇱🇻
- Lithuania 🇱🇹
- Luxembourg 🇱🇺
- Malta 🇲🇹
- Netherlands 🇳🇱
- Poland 🇵🇱
- Sweden 🇸🇪

See also the [descriptions of the structure provided by the European
Union](https://taxation-customs.ec.europa.eu/online-services/online-services-and-databases-taxation/taxpayer-identification-number-tin_en).

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
# Austria
TinValid::AustriaTin.new(tin: "…").valid? # => true

# Belgium
# Optional birth_date
TinValid::BelgiumTin.new(tin: "…", birth_date: Date.new(…)).valid?

# Bulgaria
# Optional birth_date
TinValid::BulgariaTin.new(tin: "…", birth_date: Date.new(…)).valid?

# Croatia
TinValid::CroatiaTin.new(tin: "…").valid?

# Cyprus
# Optional kind ("individual" or "company")
TinValid::CyprusTin.new(tin: "…", kind: "individual").valid?

# Czechia
# Optional birth_date
TinValid::CzechiaTin.new(tin: "…", birth_date: Date.new(…)).valid?

# Denmark
# Optional birth_date
TinValid::DenmarkTin.new(tin: "…", birth_date: Date.new(…)).valid?

# Estonia
# Optional birth_date
TinValid::EstoniaTin.new(tin: "…", birth_date: Date.new(…)).valid?

# Germany
TinValid::GermanyTin.new(tin: "…").valid?

# Greece
TinValid::GreeceTin.new(tin: "…").valid?

# Hungary
TinValid::HungaryTin.new(tin: "…").valid?

# Ireland
TinValid::IrelandTin.new(tin: "…").valid?

# Latvia
# Optional birth_date
TinValid::LatviaTin.new(tin: "…", birth_date: Date.new(…)).valid?

# Lithuania
# Optional birth_date
TinValid::LithuaniaTin.new(tin: "…", birth_date: Date.new(…)).valid?

# Luxembourg
# Optional birth_date
TinValid::LuxembourgTin.new(tin: "…", birth_date: Date.new(…)).valid?

# Malta
TinValid::MaltaTin.new(tin: "…").valid?

# Netherlands
TinValid::NetherlandsTin.new(tin: "…").valid?

# Poland
# Optional birth_date
TinValid::PolandTin.new(tin: "…", birth_date: Date.new(…)).valid?

# Sweden
# Optional birth_date
TinValid::SwedenTin.new(tin: "…", birth_date: Date.new(…)).valid?
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and the created tag, and push the `.gem` file to
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
