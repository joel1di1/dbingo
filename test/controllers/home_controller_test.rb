# frozen_string_literal: true

require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test 'should get index when not signed in' do
    get root_url

    assert_response :success
  end

  test 'should redirect to my meetings when signed in' do
    user = create :user
    sign_in(user)

    get root_url

    assert_redirected_to my_meetings_path
  end
end
