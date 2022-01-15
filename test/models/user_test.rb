# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'email is mandatory' do
    assert_raise { User.create!(email: nil) }
    assert_raise { User.create!(email: '') }
    assert_raise { User.create!(email: '  ') }
  end
end
