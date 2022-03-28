class AddTranscriptToMeeting < ActiveRecord::Migration[7.0]
  def change
    add_column :meetings, :transcript_text, :text
  end
end
