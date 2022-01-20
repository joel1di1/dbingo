# frozen_string_literal: true

require 'application_system_test_case'

class MeetingsTest < ApplicationSystemTestCase
  setup do
    @user = create :user
    @meeting = create :meeting, creator: @user

    sign_in(@user)
  end

  test 'visiting the index' do
    visit my_meetings_url
    assert_selector 'h1', text: 'My Meetings'
  end

  test 'shows meeting details ' do
    sentence = Faker::Quote.most_interesting_man_in_the_world
    @user.bet_on!(@meeting, sentence)

    visit my_meetings_url
    click_on @meeting.title

    assert_text @meeting.title
    assert_text sentence
  end

  test 'should create meeting' do
    visit my_meetings_url
    click_on 'New Meeting'

    fill_in 'Title', with: @meeting.title
    click_on 'Create Meeting'

    assert_text 'Meeting was successfully created'
  end

  test 'should update Meeting' do
    visit my_meetings_url(@meeting)
    click_on 'Edit', match: :first

    fill_in 'Title', with: @meeting.title
    click_on 'Update Meeting'

    assert_text 'Meeting was successfully updated'
  end

  test 'should destroy Meeting' do
    visit meeting_url(@meeting)
    click_on 'Edit', match: :first

    click_on 'DELETE', match: :first
    assert_text 'Meeting was successfully destroyed'
  end
end
