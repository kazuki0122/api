class CreateRules < ActiveRecord::Migration[6.0]
  def change
    create_table :rules do |t|
      t.integer :charge
      t.datetime :wakeup_time
      t.references :group, foreign_key: true
      t.boolean :checked, default: false, null: false
      t.timestamps
    end
  end
end