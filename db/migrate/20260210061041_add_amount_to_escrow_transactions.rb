class AddAmountToEscrowTransactions < ActiveRecord::Migration[8.1]
  def change
    add_column :escrow_transactions, :amount, :decimal
  end
end
