class Bid < ApplicationRecord
  # Associations
  belongs_to :request
  belongs_to :user # Freelancer

  # Validations
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :user_id, uniqueness: { scope: :request_id, message: "You have already bid on this request" }
  # custom validate
  validate :auction_must_be_open

  broadcasts_to ->(bid) { [ bid.request, :bids ] }

  # app/models/request.rb
  def self.ransackable_attributes(auth_object = nil)
      [ "id", "amount", "message", "description", "created_at", "updated_at", "request_id", "user_id" ]
  end

  # Allow searching/filtering by the associated User and Request
  def self.ransackable_associations(auth_object = nil)
    [ "request", "user" ]
  end


  private
  def auction_must_be_open
    if request.status != "open"
      errors.add(:base, "This auction is closed")
    end
  end
end
