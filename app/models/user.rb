class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, uniqueness: true
  has_many :requests, foreign_key: :client_id


  has_one_attached :avatar
  has_many :messages, dependent: :destroy
  has_many :escrow_transactions, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    # Only include columns you want to be searchable in the Admin sidebar
    [ "id", "email", "created_at", "updated_at" ]
  end

  def self.ransackable_associations(auth_object = nil)
    # Allows searching by associated models (like requests) if needed
    [ "requests" ]
  end
end
