# frozen_string_literal: true

class User < ApplicationRecord
  validates_presence_of :email
  has_many :meeting_members
  has_many :meetings, through: :meeting_members
  has_many :bets

  def to_s
    nickname || email
  end

  def bet_on!(meeting, text)
    meeting = meetings.find(meeting.id)

    bets << Bet.new(meeting: meeting, text: text)
  end

  def bets_on(meeting)
    meeting = meetings.find(meeting.id)

    bets.where(meeting: meeting)
  end
end
