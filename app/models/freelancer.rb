class Freelancer < User
    has_many :bids, dependent: :destroy
end
