# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.delete_all
newuser1 = User.new
newuser1.fullname = "Trần Quang Trí"
newuser1.email = "tranquangtri96@gmail.com"
newuser1.password = "1412578"
newuser1.save!
newuser2 = User.new
newuser2.fullname = "Lê Hoàng Vũ"
newuser2.email = "lehoangvu96@gmail.com"
newuser2.password = "1412645"
newuser2.friends.push(User.first)
newuser2.save!
newuser3 = User.new
newuser3.fullname = "Trần Hông Thuận"
newuser3.email = "tranhongthuan96@gmail.com"
newuser3.password = "1412539"
newuser3.save!
req = FriendRequest.new
req.sender_id = newuser3.id
req.receiver_id = newuser2.id
req.save!
newuser3.friend_requests_send.push(req)
newuser3.save!
# Trí gửi 5 mail cho Vũ
Mail.delete_all
(1..5).each do |item|
	newmail = Mail.new
	newmail.content = "Hello, this is #{item}-time i send you this message"
	newmail.sender = newuser1
	newmail.has_read = (item!=3)?false: true
	newmail.receiver = User.second
	newmail.save!
end

