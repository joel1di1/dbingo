# frozen_string_literal: true

require 'application_system_test_case'

class BetsTest < ApplicationSystemTestCase
  setup do
    @bet = create :bet

    @user = create :user
    sign_in(@user)
  end

  test 'visiting the index' do
    visit bets_url
    assert_selector 'h1', text: 'Listing bets'
  end

  test 'should create bet' do
    visit bets_url
    click_on 'New bet'

    fill_in 'Meeting', with: @bet.meeting_id
    fill_in 'Text', with: @bet.text
    fill_in 'User', with: @bet.user_id
    click_on 'Create Bet'

    assert_text 'Bet was successfully created'
    click_on 'Back'
  end

  test 'should update Bet' do
    visit bet_url(@bet)
    click_on 'Edit this bet', match: :first

    fill_in 'Meeting', with: @bet.meeting_id
    fill_in 'Text', with: @bet.text
    fill_in 'User', with: @bet.user_id
    click_on 'Update Bet'

    assert_text 'Bet was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Bet' do
    visit bet_url(@bet)
    click_on 'Destroy this bet', match: :first

    assert_text 'Bet was successfully destroyed'
  end
end
