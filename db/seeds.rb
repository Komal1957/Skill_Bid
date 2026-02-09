# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

#Create Root Categories
tech = Category.create(name: "Tech")
design = Category.create(name: "Design")

#Create Subcategories
web_dev = Category.create(name: "Web Development", parent: tech)
Mobile_dev = Category.create(name: "Mobile Development", parent: tech)

logo_design = Category.create(name: "Logo Design", parent: design)
ui_ux = Category.create(name: "UI/UX", parent: design)

#Create Nested Sub Categories
Ruby_on_rails = Category.create(name: "Ruby on Rails", parent: web_dev)
react = Category.create(name: "React", parent: web_dev)

['Web Development', 'Design', 'Marketing', 'Writing'].each do |name|
  Category.find_or_create_by!(name: name)
end


puts "Created #{Category.count} categories."AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?