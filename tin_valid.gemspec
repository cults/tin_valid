# frozen_string_literal: true

require_relative "lib/tin_valid/version"

Gem::Specification.new do |spec|
  spec.name = "tin_valid"
  spec.version = TinValid::VERSION
  spec.authors = ["Sunny Ripert"]
  spec.email = ["sunny@sunfox.org"]

  spec.summary = "Validate Tax Identification Numbers (TINs) in Europe"
  spec.homepage = "https://github.com/cults/tin_valid"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] =
    "https://github.com/cults/tin_valid/blob/main/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added
  # into git.
  gemspec = File.basename(__FILE__)
  excluded = %w[bin/ test/ spec/ features/ .git .github appveyor Gemfile]
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__,
                                             err: IO::NULL,) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      f == gemspec || f.start_with?(*excluded)
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
