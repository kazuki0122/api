class CreateFriendRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :friend_requests do |t|
      t.references :from, foregin_key: {to_table: :users}
      t.references :to, foregin_key: {to_table: :users}
      t.timestamps
    end
  end
end
