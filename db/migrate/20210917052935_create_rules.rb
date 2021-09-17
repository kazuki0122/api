class CreateRules < ActiveRecord::Migration[6.0]
  def change
    create_table :rules do |t|
      t.integer :charge
      t.time :wakeup_time
      t.references :group, foreign_key: true
      t.timestamps
    end
  end
end
