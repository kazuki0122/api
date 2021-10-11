class CreateResults < ActiveRecord::Migration[6.0]
  def change
    create_table :results do |t|
      t.boolean :result, null: false
      t.references :rule
      t.references :user
      t.references :payment
      t.timestamps
    end
  end
end
