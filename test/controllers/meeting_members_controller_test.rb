# frozen_string_literal: true

require 'test_helper'

class MeetingMembersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create :user
    sign_in(@user)
  end

  test 'should create meeting_member' do
    meeting = create :meeting

    assert_difference('MeetingMember.count') do
      post meeting_meeting_members_url(meeting_id: meeting.id)
    end

    assert_redirected_to meeting_url(meeting)
  end

  test 'should destroy meeting_member' do
    @meeting_member = create :meeting_member, user: @user

    assert_difference('MeetingMember.count', -1) do
      delete meeting_meeting_member_url(@meeting_member, meeting_id: @meeting_member.meeting.id)
    end

    assert_redirected_to root_url
  end
end
