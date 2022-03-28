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

  test 'counts occurences' do
    script = """Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non risus. Suspendisse lectus tortor, dignissim sit amet, adipiscing nec, ultricies sed, dolor. Cras elementum ultrices diam. Maecenas ligula massa, varius a, semper congue, euismod non, mi. Proin porttitor, orci nec nonummy molestie, enim est eleifend mi, non fermentum diam nisl sit amet erat. Duis semper. Duis arcu massa, scelerisque vitae, consequat in, pretium a, enim. Pellentesque congue. Ut in risus volutpat libero pharetra tempor. Cras vestibulum bibendum augue. Praesent egestas leo in pede. Praesent blandit odio eu enim. Pellentesque sed dui ut augue blandit sodales. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Aliquam nibh. Mauris ac mauris sed pede pellentesque fermentum. Maecenas adipiscing ante non diam sodales hendrerit. """
    bets = ['Lorem ipsum', 'ligula', 'enim', 'eu enim']

    bets_score = (create :meeting).send(:count_occurences, bets, script)
    expectation = { "lorem ipsum": 1, "ligula": 1, "enim": 3, "eu enim": 1 }.map { |key, value| [key.to_s, value] }.to_h
    assert_equal(expectation, bets_score)
  end
end
