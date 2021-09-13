class CreateFriends < ActiveRecord::Migration[6.0]
  def change
    create_table :friends do |t|
      t.references :from, foregin_key: {to_table: :users}
      t.references :to, foregin_key: {to_table: :users}
      t.timestamps
    end
  end
end
