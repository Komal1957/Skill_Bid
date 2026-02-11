class AddStatusToEscrowTransactions < ActiveRecord::Migration[8.1]
  def change
    add_column :escrow_transactions, :status, :integer
  end
end
