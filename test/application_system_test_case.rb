# frozen_string_literal: true

require 'test_helper'
require 'rack_session_access/capybara'

TEST_BROWSER = 'false' == ENV['HEADLESS'] ? :chrome : :headless_chrome

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: TEST_BROWSER, screen_size: [1400, 1400]
  include FactoryBot::Syntax::Methods

  def sign_in(user)
    page.set_rack_session(user_id: user.id)
  end
end
