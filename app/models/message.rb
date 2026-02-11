class Message < ApplicationRecord
  belongs_to :user
  belongs_to :request

  validates :content, presence: true
  # Broadcast to the stream for this specific request
  broadcasts_to ->(message) { [ message.request, :messages ] }, target: "messages_container"
end
