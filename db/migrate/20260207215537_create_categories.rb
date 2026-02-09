class CreateCategories < ActiveRecord::Migration[8.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.references :parent, null: false, foreign_key: { to_table: :categories }

      t.timestamps
    end
  end
end
