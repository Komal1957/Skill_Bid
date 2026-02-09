class Client < User
    has_many :requests, dependent: :destroy
end
