## [Unreleased]

Fixes:
- Fix Belgium to ignore `-` and `.` 🇧🇪

## [1.3.0] - 2025-12-12

Features:
- Add `TinValid::COUNTRY_CODES` to get available country codes.

Fixes:
- Fix Bulgaria to accept TINs starting with `10` instead of `00` 🇧🇬
- Fix Finland checks for tins ending in `P` 🇫🇮
- Fix Denmark check for certain ranges of birth years 🇩🇰

## [1.2.1] - 2025-05-22

Fixes:
- Accept `/` for Czechia 🇨🇿
- `TinValid::Tin.new` accept symbols or uppercase country codes.
- `kind` argument accept symbols.

## [1.2.0] - 2025-05-14

Features:
- Add generic `TinValid::Tin.new(country_code: "…", tin: "…").valid?`
- Add `#siren?` and `#siret?` on `TinValid::FranceTin` 🇫🇷

Fixes:
- Accept SIRET for France 🇫🇷

## [1.1.2] - 2025-05-06

Fixes:
- Fix Luxembourg check 🇱🇺
- Accept SIREN for France 🇫🇷

## [1.1.1] - 2025-04-28

Fixes:
- Fix birth date check for Italy when year is between 1900..1909 or between
  2000..2009 🇮🇹

## [1.1.0] - 2025-04-18

Features:
- Add Finland 🇫🇮
- Add France 🇫🇷

Fixes:
- Test against clearly invalid codes 00000… and 123456…
- Check that all dates are in the past

## [1.0.0] - 2025-04-17

Features:
- Add Italy 🇮🇹
- Add Latvia 🇱🇻
- Add Luxembourg 🇱🇺
- Add Lithuania 🇱🇹
- Add Malta 🇲🇹
- Add Netherlands 🇳🇱
- Add Poland 🇵🇱
- Add Portugal 🇵🇹
- Add Romania 🇷🇴
- Add Slovakia 🇸🇰
- Add Slovenia 🇸🇮
- Add Spain 🇪🇸
- Add United Kingdom 🇬🇧

## [0.1.1] - 2025-04-15

Features:
- Add Germany 🇩🇪
- Add Greece 🇬🇷
- Add Hungary 🇭🇺
- Add Ireland 🇮🇪

## [0.1.0] - 2025-04-14

Features:
- Add Austria 🇦🇹
- Add Belgium 🇧🇪
- Add Bulgaria 🇧🇬
- Add Croatia 🇭🇷
- Add Cyprus 🇨🇾
- Add Czechia 🇨🇿
- Add Denmark 🇩🇰
- Add Estonia 🇪🇪
- Add Germany 🇩🇪
- Add Greece 🇬🇷
- Add Sweden 🇸🇪
