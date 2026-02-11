class EscrowTransaction < ApplicationRecord
  belongs_to :user
  belongs_to :request
   enum :status, { pending: 0, completed: 1, cancelled: 2 }
end
