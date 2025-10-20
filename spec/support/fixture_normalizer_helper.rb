# frozen_string_literal: true

module FixtureNormalizerHelper
  # Transform keys to symbols, values to strings and remove nil or empty values
  def normalize_fixture(hash)
    hash.map do |key, value|
      value.to_s.empty? ? nil : [key.to_sym, value.to_s]
    end.compact.to_h
  end
end
