class CreateTransactions < ActiveRecord::Migration[8.1]
  def change
    create_table :transactions do |t|
      t.decimal :amount
      t.integer :status
      t.references :user, null: false, foreign_key: true
      t.references :request, null: false, foreign_key: true
      t.string :type

      t.timestamps
    end
  end
end
