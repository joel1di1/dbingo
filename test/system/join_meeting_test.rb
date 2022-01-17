# frozen_string_literal: true

require 'application_system_test_case'

class JoinMeetingTest < ApplicationSystemTestCase
  setup do
    @meeting = create :meeting

    @user = create :user
    sign_in(@user)
  end

  test 'join a meeting' do
    visit meeting_url(@meeting)
    assert_text @meeting.title

    click_on 'Join the meeting'

    assert_text 'Meeting joined!'
  end

end