class CreateBids < ActiveRecord::Migration[8.1]
  def change
    create_table :bids do |t|
      t.string :amount
      t.text :message
      t.references :request, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
