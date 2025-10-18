# frozen_string_literal: true

module MatcherHelper
  def str_or_nil(string)
    return nil if string.nil?
    return nil if string == ''

    string.to_s
  end
end
