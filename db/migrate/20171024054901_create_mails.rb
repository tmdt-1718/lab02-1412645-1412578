class CreateMails < ActiveRecord::Migration[5.1]
  def change
    create_table :mails do |t|
	  t.integer :sender_id
	  t.integer :receiver_id
    t.string :title
    t.string :content
    t.boolean :has_read
    t.date :time_read
    t.timestamps
    end
  end
end
