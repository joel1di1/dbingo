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
    unless meeting.begun?
      meeting = meetings.find(meeting.id)
      raise "Max bet number reached for #{self} on #{meeting}" if bets_on(meeting).count >= Bet::MAX_BET_PER_MEETING

      bets << Bet.new(meeting:, text:)
    end
  end

  def bets_on(meeting)
    meeting = meetings.find(meeting.id)

    bets.where(meeting:)
  end

  def member_of?(meeting)
    meetings.include?(meeting)
  end

  def join!(meeting)
    meetings << meeting unless meetings.include?(meeting)
  end

  def unjoin!(meeting)
    meetings.delete(meeting)
  end

  def score(meeting)
    compute_score(bets_on(meeting), meeting.transcript_text)
  end

end
