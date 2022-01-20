# frozen_string_literal: true

require 'test_helper'

class BetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create :user
    @meeting = create :meeting, creator: @user
    @bet = create :bet, user: @user, meeting: @meeting

    sign_in(@user)
  end

  test 'should get index' do
    get meeting_bets_url(meeting_id: @meeting.id)
    assert_response :success
  end

  test 'should create bet' do
    assert_difference('Bet.count') do
      post meeting_bets_url(meeting_id: @bet.meeting_id), params: { bet: {text: @bet.text } }
    end

    assert_redirected_to meeting_url(@meeting)
  end

  test 'should destroy bet' do
    assert_difference('Bet.count', -1) do
      delete meeting_bet_url(@meeting, @bet)
    end

    assert_redirected_to meeting_url(@meeting)
  end
end
