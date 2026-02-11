ActiveAdmin.register User do
  # Allow searching by email
  filter :email
  # Allow searching by role (Client/Freelancer)
  filter :type, as: :select, collection: [ "Client", "Freelancer", "Admin" ]
  remove_filter :type

  index do
    selectable_column
    id_column
    column :email
    column :type # Shows if they are Client or Freelancer
    column :created_at
    actions
  end
end
