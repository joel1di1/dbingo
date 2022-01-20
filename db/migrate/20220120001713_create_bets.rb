class CreateBets < ActiveRecord::Migration[7.0]
  def change
    create_table :bets do |t|
      t.references :user, null: false, foreign_key: true
      t.uuid :meeting_id, null: false
      t.string :text

      t.timestamps
    end

    add_foreign_key :bets, :meetings, column: :meeting_id, primary_key: :id
  end
end
