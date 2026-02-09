class AddClientToRequests < ActiveRecord::Migration[8.1]
  def change
    add_reference :requests, :client, null: false, foreign_key: { to_table: :users }
  end
end
