# frozen_string_literal: true

class Meeting < ApplicationRecord
  self.implicit_order_column = 'created_at'

  belongs_to :creator, class_name: 'User', foreign_key: :creator_id
  has_many :meeting_members, dependent: :destroy
  has_many :users, through: :meeting_members

  before_create :add_creator_as_member

  def add_member!(user)
    users << user unless users.include?(user)
  end

  def remove_member!(user)
    users.delete(user)
  end

  private

  def add_creator_as_member
    users << creator
  end
end
