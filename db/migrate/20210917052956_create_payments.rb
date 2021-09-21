class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.integer :amount
      t.boolean :payed, default: false, null: false
      t.timestamps
    end
  end
end
