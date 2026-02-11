class Category < ApplicationRecord
  # A catgory belongs to an optional parent(e.g., "ROR" belongs to "Web")
  belongs_to :parent, class_name: "Category", optional: true


  # A category has many subcategories (e.g, "Web" has many "ROR", "React" etc)
  has_many :subcategories, class_name: "Category", foreign_key: :parent_id, dependent: :nullify

  # Request associated with a category
  has_many :requests, dependent: :nullify

  validates :name, presence: true

  def self.ransackable_attributes(auth_object = nil)
    [ "id", "name", "created_at", "updated_at", "parent_id" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "parent", "requests", "subcategories" ]
  end
end
