class CreateEscrowTransactions < ActiveRecord::Migration[8.1]
  def change
    create_table :escrow_transactions do |t|
      t.timestamps
    end
  end
end
