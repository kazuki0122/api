class CreateCards < ActiveRecord::Migration[6.0]
  def change
    create_table :cards do |t|
      t.string :customer_id, null: false
      t.string :payment_method_id
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
