class CreateFriendships < ActiveRecord::Migration[5.1]
  def change
    create_table :friendships do |t|
    	t.integer :user_id
    	t.integer :friend_id
    	t.index [:user_id, :friend_id], unique: true
    	t.index [:friend_id, :user_id], unique: true
    end
  end
end
