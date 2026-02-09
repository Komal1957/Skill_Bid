class AddDescriptionToBids < ActiveRecord::Migration[8.1]
  def change
    add_column :bids, :description, :text
  end
end
