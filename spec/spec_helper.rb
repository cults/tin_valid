# frozen_string_literal: true

require "tin_valid"

RSpec.configure do |config|
  if config.files_to_run.one?
    # Use the documentation formatter for detailed output, unless a formatter
    # has already been configured (e.g. via a command-line flag).
    config.default_formatter = "doc"
  end

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
