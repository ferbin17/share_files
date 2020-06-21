class CreateFileSenders < ActiveRecord::Migration[6.0]
  def change
    create_table :file_senders do |t|
      t.string :uuid
      t.integer :total_file_size, default: 0
      t.integer :uploaded_size, default: 0
      t.datetime :expiry_date
      t.boolean :sender_mail_sent, default: false
      t.boolean :receiver_mail_sent, default: false
      t.integer :sender_id
      t.integer :receiver_id 
      t.boolean :is_expired
      t.timestamps
    end
  end
end
