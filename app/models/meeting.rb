# frozen_string_literal: true

class Meeting < ApplicationRecord
  self.implicit_order_column = 'created_at'

  belongs_to :creator, class_name: 'User', foreign_key: :creator_id
  has_many :meeting_members, dependent: :destroy
  has_many :users, through: :meeting_members
  has_one_attached :transcript

  before_create :add_creator_as_member

  def begun?
    Time.zone.now > start_at
  end

  private

  def add_creator_as_member
    users << creator
  end
end
