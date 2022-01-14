# frozen_string_literal: true

require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = create :user
  end

  test 'user can login' do
    visit root_url

    click_on 'Dev login'

    fill_in 'name', with: @user.nickname
    fill_in 'email', with: @user.email

    click_on 'Sign In'

    assert_text @user.nickname
  end
end
