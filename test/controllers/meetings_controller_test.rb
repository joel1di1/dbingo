# frozen_string_literal: true

require 'test_helper'

class MeetingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create :user
    @meeting = create :meeting, creator: @user

    sign_in(@user)
  end

  test 'should get my_meetings' do
    get my_meetings_url
    assert_response :success
  end

  test 'should get new' do
    get new_meeting_url
    assert_response :success
  end

  test 'should create meeting' do
    assert_difference('Meeting.count') do
      post meetings_url,
           params: { meeting: { end_at: @meeting.end_at, start_at: @meeting.start_at,
                                title: @meeting.title } }
    end

    assert_redirected_to meeting_url(Meeting.last)
  end

  test 'should show meeting' do
    get meeting_url(@meeting)
    assert_response :success
  end

  test 'should get edit' do
    get edit_meeting_url(@meeting)
    assert_response :success
  end

  test 'should update meeting' do
    patch meeting_url(@meeting),
          params: { meeting: { creator_id: @meeting.creator_id, end_at: @meeting.end_at, start_at: @meeting.start_at,
                               title: @meeting.title } }
    assert_redirected_to meeting_url(@meeting)
  end

  test 'should destroy meeting' do
    assert_difference('Meeting.count', -1) do
      delete meeting_url(@meeting)
    end

    assert_redirected_to my_meetings_url
  end

  test 'cannnot destroy meeting when no creator' do
    other_meeting = create :meeting

    assert_no_difference('Meeting.count') do
      assert_raise do
        delete meeting_url(other_meeting)
      end
    end
  end

end
