# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'email is mandatory' do
    assert_raise { User.create!(email: nil) }
    assert_raise { User.create!(email: '') }
    assert_raise { User.create!(email: '  ') }
  end

  test 'to_s shows nickname' do
    user = create :user
    assert_equal user.nickname, user.to_s

    user = create :user, nickname: nil
    assert_equal user.email, user.to_s
  end
end
