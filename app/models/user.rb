# frozen_string_literal: true

class User < ApplicationRecord
  validates_presence_of :email
  has_many :meeting_members
  has_many :meetings, through: :meeting_members
end
