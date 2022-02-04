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

  def compute_score(bets, text)
    count_occurences(bets.map(&:text), text)
      .map { |bet, occurence_count| bet.split.size * occurence_count }.sum
  end

  def score(meeting)
    compute_score(bets_on(meeting), meeting.transcript.download)
  end

  private

  def count_occurences(bets, script)
    script = script.downcase.gsub(/[[:punct:]]+/, ' ').gsub(/ +/, ' ')
    bets_score = bets.map!(&:downcase).index_with(0)

    candidates = {}

    script.split.each do |script_word|
      remaining_candidates = candidates
      candidates = {}

      remaining_candidates.each do |left, candidate_bet|
        if left == script_word
          bets_score[candidate_bet] += 1
          next
        end
        if left =~ /^#{script_word} /
          left.gsub!(/^#{script_word} /, '')
          candidates[left] = candidate_bet
        end
      end

      bets.each do |candidate_bet|
        if candidate_bet == script_word
          bets_score[candidate_bet] += 1
          next
        end
        if candidate_bet =~ /^#{script_word} /
          left = candidate_bet.gsub(/^#{script_word} /, '')
          candidates[left] = candidate_bet
        end

      end
    end
    bets_score
  end

end
