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

  test 'bets on text' do
    user = create :user
    meeting = create :meeting, creator: user

    text = 'some text'
    assert_difference 'user.bets_on(meeting).count' do
      user.bet_on!(meeting, text)
    end
  end

  test '#bet_on! raise if user did not joined' do
    user = create :user
    meeting = create :meeting

    assert_raise do
      user.bet_on!(meeting, 'wrong bet')
    end
  end

  test '#bets_on raise if user did not joined' do
    user = create :user
    meeting = create :meeting

    assert_raise do
      user.bets_on(meeting)
    end
  end
end
