# frozen_string_literal: true

class Bet < ApplicationRecord
  MAX_BET_PER_MEETING = 10

  belongs_to :user
  belongs_to :meeting
end
