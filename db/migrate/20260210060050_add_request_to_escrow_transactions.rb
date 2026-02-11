class AddRequestToEscrowTransactions < ActiveRecord::Migration[8.1]
  def change
    add_reference :escrow_transactions, :request, null: false, foreign_key: true
  end
end
