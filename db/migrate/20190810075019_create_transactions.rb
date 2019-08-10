class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.string :transaction_id, :limit => 8
      t.string :mode
      t.decimal :amount, precision: 6, scale: 2
      t.references :sender_account, foreign_key: { to_table: :accounts }, index: true
      t.references :recipient_account, foreign_key: { to_table: :accounts }, null: false, index: true
      t.references :created_by, foreign_key: { to_table: :users }, null: false
      t.timestamps
    end
  end
end
