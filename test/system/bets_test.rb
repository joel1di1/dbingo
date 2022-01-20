# frozen_string_literal: true

require 'application_system_test_case'

class BetsTest < ApplicationSystemTestCase
  setup do
    @user = create :user
    @meeting = create :meeting, creator: @user
    @bet = create :bet, user: @user, meeting: @meeting

    sign_in(@user)
  end

  test 'should create bet' do
    visit meeting_url(@meeting)
    click_on 'New Bet'

    fill_in 'Meeting', with: @bet.meeting_id
    fill_in 'Text', with: @bet.text
    fill_in 'User', with: @bet.user_id
    click_on 'Create Bet'

    assert_text 'Bet was successfully created'
    click_on 'Back'
  end

  test 'should destroy Bet' do
    visit meeting_url(@meeting)

    click_on 'Destroy', match: :first

    assert_text 'Bet was successfully destroyed'
  end
end
