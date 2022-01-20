class CreateBets < ActiveRecord::Migration[7.0]
  def change
    create_table :bets do |t|
      t.references :user, null: false, foreign_key: true
      t.references :meeting, null: false, foreign_key: true
      t.string :text

      t.timestamps
    end
  end
end
