# frozen_string_literal: true

require 'application_system_test_case'

class JoinMeetingTest < ApplicationSystemTestCase
  setup do
    @user = create :user
    sign_in(@user)
  end

  test 'home shows my meetings' do
    one_of_my_meeting = create :meeting, creator: @user
    not_one_of_my_meeting = create :meeting

    visit root_url

    assert_text one_of_my_meeting.title
    assert_no_text not_one_of_my_meeting.title
  end
end
