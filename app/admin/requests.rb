ActiveAdmin.register Request do
  permit_params :title, :description, :budget, :status, :category_id
  filter :title
  filter :client
  filter :category
  filter :status, as: :select, collection: Request.statuses
  filter :budget
  filter :created_at
  index do
    selectable_column
    id_column
    column :title
    column :budget do |request|
      number_to_currency(request.budget)
    end
    column :status
    column :created_at
    actions
  end
end