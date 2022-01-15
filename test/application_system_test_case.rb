# frozen_string_literal: true

require 'test_helper'
require "rack_session_access/capybara"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
  include FactoryBot::Syntax::Methods

  def login(user)
    page.set_rack_session(user_id: user.id)
  end
end
