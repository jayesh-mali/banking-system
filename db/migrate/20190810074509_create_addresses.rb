class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :city, index: true
      t.integer :pin_code
      t.string :district, index: true
      t.string :state
      t.string :country
      t.references :user, index: true, null: false
      t.timestamps
    end
  end
end
