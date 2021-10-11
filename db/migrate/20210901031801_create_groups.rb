class CreateGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :groups do |t|
      t.string :name
      t.references :creater, foregin_key: {to_table: :users}
      t.index :name, unique: true
      t.timestamps
    end
  end
end
