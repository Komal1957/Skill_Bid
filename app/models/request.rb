class Request < ApplicationRecord
  # Associations
  belongs_to :client, class_name: "User", foreign_key: "user_id"
  belongs_to :category
  has_many :bids, dependent: :destroy

  # Enums

  enum :status, { open: 0, closed: 1, completed: 2, disputed: 3 }


  # Validations
  validates :title, :description, :budget, :expires_at, presence: true
  validates :budget, numericality: { greater_than_or_equal_to: 0.01 }
  has_many_attached :files
  has_many :messages, dependent: :destroy
  has_many :escrow_transactions, dependent: :destroy

  # Helper to get the current lowest bid
  def lowest_bid
    bids.order(amount: :asc).first
  end

  # app/models/request.rb
  def self.ransackable_attributes(auth_object = nil)
      [ "id", "title", "description", "status", "budget", "created_at", "updated_at", "category_id", "client_id" ]
  end

  # Allow filtering by these associations
  def self.ransackable_associations(auth_object = nil)
    [ "bids", "category", "client", "files_attachments", "files_blobs" ]
  end
end
