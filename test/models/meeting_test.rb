# frozen_string_literal: true

require 'test_helper'

class MeetingTest < ActiveSupport::TestCase
  test 'creator is member of meeting' do
    user = create :user
    meeting = create :meeting, creator: user

    assert meeting.users.include?(user)
    assert user.meetings.include?(meeting)
    assert user.member_of?(meeting)
  end
end
