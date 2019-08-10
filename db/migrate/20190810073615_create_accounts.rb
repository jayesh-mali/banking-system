class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :account_type
      t.integer :account_number, :limit => 8, index: true, null: false
      t.decimal :balance, precision: 6, scale: 2, default: 0
      t.references :user, index: true, null: false
      t.references :created_by, foreign_key: { to_table: :users }, null: false
      t.references :updated_by, foreign_key: { to_table: :users }, null: false
      t.timestamps
    end
  end
end
