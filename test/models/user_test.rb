# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'email is mandatory' do
    assert_not User.create!(email: nil)
    assert_not User.create!(email: '')
    assert_not User.create!(email: '  ')
  end
end
