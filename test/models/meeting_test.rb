# frozen_string_literal: true

require 'test_helper'

class MeetingTest < ActiveSupport::TestCase
  test 'creator is member of meeting' do
    user = create :user
    meeting = create :meeting, creator: user

    assert meeting.users.include?(user)
    assert user.meetings.include?(meeting)
  end

  test 'add member only if not already member' do
    meeting = create :meeting
    user = create :user

    assert_difference 'meeting.reload.users.count' do
      3.times { meeting.add_member!(user) }
    end
    assert_equal [meeting.creator, user].sort, meeting.users.sort
  end
end
