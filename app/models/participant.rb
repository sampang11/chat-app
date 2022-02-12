class Participant < ApplicationRecord
  belongs_to :sender, :foreign_key => :sender_id, class_name: 'User'
  belongs_to :recipient, :foreign_key => :recipient_id, class_name: 'User'

  has_many :messages, dependent: :destroy

  validates_uniqueness_of :sender_id, :scope => :recipient_id

  # this lambda functions works if sender is actual sender or the recipient and vice versa
  scope :message_exchange, -> (sender_id, recipient_id) do
    where("(participants.sender_id = ? AND participants.recipient_id = ?)
    OR (participants.sender_id = ? AND participants.recipient_id = ?)",
      sender_id, recipient_id, recipient_id, sender_id)
  end
end
