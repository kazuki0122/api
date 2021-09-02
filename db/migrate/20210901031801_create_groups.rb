class CreateGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :groups do |t|
      t.string :name
      t.index :name, unique: true
      t.timestamps
    end
  end
end
