class Transaction < ApplicationRecord
  belongs_to :user # The Client (payer)
  belongs_to :request # The request being funded

  # Statuses: 0: Pending, 1: Completed (Paid to Stripe), 2: Released (Paid to Freelancer)
  enum :status, { pending: 0, completed: 1, released: 2 }

  validates :amount, presence: true
end
