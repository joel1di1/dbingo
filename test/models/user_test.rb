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

    Bet::MAX_BET_PER_MEETING.times do
      assert_difference 'user.bets_on(meeting).count' do
        user.bet_on!(meeting, Faker::Quote.most_interesting_man_in_the_world)
      end
    end

    assert_raise do
      user.bet_on!(meeting, Faker::Quote.most_interesting_man_in_the_world)
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

  test 'member of meeting' do
    user = create :user
    meeting = create :meeting

    assert_not user.member_of?(meeting)

    user.join!(meeting)
    assert user.member_of?(meeting)

    user.unjoin!(meeting)
    assert_not user.member_of?(meeting)
  end

  test 'user joins only if not already member, otherwise it do nothing' do
    meeting = create :meeting
    user = create :user

    assert_difference 'meeting.reload.users.count' do
      3.times { user.join!(meeting) }
    end
    assert_equal [meeting.creator, user].sort, meeting.users.sort
  end




end
