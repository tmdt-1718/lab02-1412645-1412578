class Mail < ApplicationRecord
	has_and_belongs_to_many :receivers,
	class_name: "User",
	join_table: :mails_users,
	foreign_key: :mail_id,
	association_foreign_key: :receiver_id
	belongs_to :sender,
	class_name: "User",
	foreign_key: "sender_id"
	belongs_to :receiver,
	class_name: "User",
	foreign_key: "receiver_id"
end
