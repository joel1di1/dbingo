# frozen_string_literal: true

class Meeting < ApplicationRecord
  BASE_SCORE = 100
  self.implicit_order_column = 'created_at'

  belongs_to :creator, class_name: 'User', foreign_key: :creator_id
  has_many :meeting_members, dependent: :destroy
  has_many :users, through: :meeting_members
  has_one_attached :transcript

  before_create :add_creator_as_member

  def begun?
    Time.zone.now > start_at
  end

  def compute_score
    bets = Bet.where(meeting: self)
    score_by_bet = bets.group_by { |bet| bet.text.downcase }.transform_values { |bet_array| BASE_SCORE/bet_array.size }
    return {} if transcript_text.nil?

    users.each_with_object({}) do |user, scores|
      scores[user.email] = compute_user_score(bets.where(user_id: user.id), transcript_text, score_by_bet)
    end
  end

  private

  def add_creator_as_member
    users << creator
  end

  def compute_user_score(bets, script, score_by_bet)
    count_occurences(bets.map(&:text), script)
      .map { |bet, occurence_count| score_by_bet[bet] * bet.split.size * occurence_count }.sum
  end

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
          left = left.gsub(/^#{script_word} /, '')
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
