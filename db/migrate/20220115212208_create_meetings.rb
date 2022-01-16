# frozen_string_literal: true

class CreateMeetings < ActiveRecord::Migration[7.0]
  def change
    create_table :meetings do |t|
      t.string :title, null: false
      t.datetime :start_at, null: false
      t.datetime :end_at, null: false
      t.references :creator, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
