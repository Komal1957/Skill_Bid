class CreateRequests < ActiveRecord::Migration[8.1]
  def change
    create_table :requests do |t|
      t.string :title
      t.text :description
      t.decimal :budget
      t.integer :status
      t.datetime :expires_at
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
