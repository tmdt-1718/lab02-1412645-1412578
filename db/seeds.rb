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
newuser2.email = "tranquangtri96@live.com"
newuser2.password = "1412645"
newuser2.friends.push(User.first)
newuser2.save!
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

