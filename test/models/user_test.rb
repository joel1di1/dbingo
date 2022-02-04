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

  test 'we can calculate the score for a given meeting' do
    meeting = create :meeting
    text = 'I am super happy to meet you'
    user = create :user
    user.join!(meeting)
    user.bet_on!(meeting, 'super happy')
    user.bet_on!(meeting, 'meet')

    assert_equal 3, user.compute_score(user.bets_on(meeting), text)
  end

  test 'counts occurences' do
    script = """Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non risus. Suspendisse lectus tortor, dignissim sit amet, adipiscing nec, ultricies sed, dolor. Cras elementum ultrices diam. Maecenas ligula massa, varius a, semper congue, euismod non, mi. Proin porttitor, orci nec nonummy molestie, enim est eleifend mi, non fermentum diam nisl sit amet erat. Duis semper. Duis arcu massa, scelerisque vitae, consequat in, pretium a, enim. Pellentesque congue. Ut in risus volutpat libero pharetra tempor. Cras vestibulum bibendum augue. Praesent egestas leo in pede. Praesent blandit odio eu enim. Pellentesque sed dui ut augue blandit sodales. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Aliquam nibh. Mauris ac mauris sed pede pellentesque fermentum. Maecenas adipiscing ante non diam sodales hendrerit. """
    bets = ['Lorem ipsum', 'ligula', 'enim', 'eu enim']

    bets_score = (create :user).send(:count_occurences, bets, script)
    expectation = { "lorem ipsum": 1, "ligula": 1, "enim": 3, "eu enim": 1 }.map { |key, value| [key.to_s, value] }.to_h
    assert_equal(expectation, bets_score)
  end
end
