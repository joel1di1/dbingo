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
    click_on 'Create Bet'

    fill_in 'bet[text]', with: @bet.text
    click_on 'Create Bet'

    assert_text 'Bet was successfully created'
  end

  test 'should destroy Bet' do
    visit meeting_url(@meeting)

    click_on 'X', match: :first

    assert_text 'Bet was successfully destroyed'
  end
end
