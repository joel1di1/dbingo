# frozen_string_literal: true

require 'application_system_test_case'

class MeetingsTest < ApplicationSystemTestCase
  setup do
    @meeting = create :meeting

    @user = create :user
    sign_in(@user)
  end

  test 'visiting the index' do
    visit meetings_url
    assert_selector 'h1', text: 'Listing meetings'
  end

  test 'should create meeting' do
    visit meetings_url
    click_on 'New Meeting'

    fill_in 'Title', with: @meeting.title
    click_on 'Create Meeting'

    assert_text 'Meeting was successfully created'
    click_on 'Back'
  end

  test 'should update Meeting' do
    visit meeting_url(@meeting)
    click_on 'Edit', match: :first

    fill_in 'Title', with: @meeting.title
    click_on 'Update Meeting'

    assert_text 'Meeting was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Meeting' do
    visit meeting_url(@meeting)
    click_on 'Edit', match: :first

    click_on 'DELETE', match: :first
    assert_text 'Meeting was successfully destroyed'
  end
end
