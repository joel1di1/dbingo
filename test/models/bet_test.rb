# frozen_string_literal: true

require 'test_helper'

class BetTest < ActiveSupport::TestCase
  test 'the truth' do
    bet = create(:bet)
    assert bet
  end
end
