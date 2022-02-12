class Message < ApplicationRecord
  belongs_to :participant
  belongs_to :user

  validates_presence_of :body, :participant_id, :user_id

  scope :sort_by_date, ->(direction) { order("created_at #{direction}") }
end
