# frozen_string_literal: true

require 'test_helper'

class MeetingTest < ActiveSupport::TestCase
  setup do
    @user = create :user
    @meeting = create :meeting, creator: @user
  end
  test 'creator is member of meeting' do
    user = create :user
    meeting = create :meeting, creator: user

    assert meeting.users.include?(user)
    assert user.meetings.include?(meeting)
    assert user.member_of?(meeting)
  end

  test 'counts occurences' do
    script = "" "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non risus. Suspendisse lectus tortor, dignissim sit amet, adipiscing nec, ultricies sed, dolor. Cras elementum ultrices diam. Maecenas ligula massa, varius a, semper congue, euismod non, mi. Proin porttitor, orci nec nonummy molestie, enim est eleifend mi, non fermentum diam nisl sit amet erat. Duis semper. Duis arcu massa, scelerisque vitae, consequat in, pretium a, enim. Pellentesque congue. Ut in risus volutpat libero pharetra tempor. Cras vestibulum bibendum augue. Praesent egestas leo in pede. Praesent blandit odio eu enim. Pellentesque sed dui ut augue blandit sodales. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Aliquam nibh. Mauris ac mauris sed pede pellentesque fermentum. Maecenas adipiscing ante non diam sodales hendrerit. " ""
    bets = ['Lorem ipsum', 'ligula', 'enim', 'eu enim']

    bets_score = (create :meeting).send(:count_occurences, bets, script)
    expectation = { "lorem ipsum": 1, "ligula": 1, "enim": 3, "eu enim": 1 }.map { |key, value| [key.to_s, value] }.to_h
    assert_equal(expectation, bets_score)
  end

  test 'it computes all users scores with 0 when no matching bet' do
    assert_equal({}, @meeting.compute_score)

    create(:bet, user: @user, meeting: @meeting)
    @meeting.reload
    assert_equal({}, @meeting.compute_score)

    @meeting.transcript_text = ('This is amazing')
    assert_equal({ @user.email => 0 }, @meeting.compute_score)
  end

  test 'it computes score for user with matching bet' do
    create(:bet, user: @user, meeting: @meeting, text: 'amazing')
    @meeting.update(transcript_text: 'This is amazing')
    assert_equal({ @user.email => 100 }, @meeting.reload.compute_score)
  end

  test 'it computes score for two users with matching bet' do
    user2 = create(:user)
    @meeting.users << user2
    create(:bet, user: @user, meeting: @meeting, text: 'amazing')
    create(:bet, user: user2, meeting: @meeting, text: 'amazing')
    assert_equal({}, @meeting.compute_score)

    @meeting.transcript_text = 'This is amazing'

    assert_equal({ @user.email => 50, user2.email => 50 }, @meeting.compute_score)
  end

  test 'it computes score for a two words bet' do
    create(:bet, user: @user, meeting: @meeting, text: 'super happy')
    assert_equal({}, @meeting.compute_score)

    @meeting.transcript_text = 'I am super happy, this is amazing'

    assert_equal({ @user.email => 200 }, @meeting.compute_score)
  end
end
