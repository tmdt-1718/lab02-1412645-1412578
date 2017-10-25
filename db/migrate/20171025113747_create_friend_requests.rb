class CreateFriendRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :friend_requests do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.index [:sender_id, :receiver_id]
      t.timestamps
    end
  end
end
