# frozen_string_literal: true

module TinValid
  module Helpers
    private

    def date(year, month, day)
      found_date = Date.new(year.to_i, month.to_i, day.to_i)
      found_date if found_date < Date.today
    rescue Date::Error
      nil
    end
  end
end
