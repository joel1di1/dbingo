# frozen_string_literal: true

json.extract! meeting, :id, :title, :start_at, :end_at, :creator_id, :created_at, :updated_at
json.url meeting_url(meeting, format: :json)
