# frozen_string_literal: true

class CreateMeetingMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :meeting_members do |t|
      t.references :user, null: false, foreign_key: true
      t.uuid :meeting_id, null: false

      t.timestamps
    end

    add_foreign_key :meeting_members, :meetings, column: :meeting_id, primary_key: :id
  end
end
