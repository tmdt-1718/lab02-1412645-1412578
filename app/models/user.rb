class User < ApplicationRecord
	has_and_belongs_to_many :friends,
	class_name: "User",
	join_table: :friendships,
	foreign_key: :user_id,
	association_foreign_key: :friend_id
	def password
		@password ||= BCrypt::Password.new(password_hash)
	end
	def password=(new_password)
		@password = BCrypt::Password.create(new_password)
		self.password_hash = @password
	end
end
