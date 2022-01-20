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
    raise "Max bet number reached for #{self} on #{meeting}" if bets_on(meeting).count >= Bet::MAX_BET_PER_MEETING

    bets << Bet.new(meeting:, text:)
  end

  def bets_on(meeting)
    meeting = meetings.find(meeting.id)

    bets.where(meeting:)
  end
end
