class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.integer :amount
      t.references :result
      t.boolean :payed, null: false
      t.timestamps
    end
  end
end
