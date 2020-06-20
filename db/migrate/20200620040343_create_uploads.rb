class CreateUploads < ActiveRecord::Migration[6.0]
  def change
    create_table :uploads do |t|
      t.string :uuid
      t.string :filename
      t.integer :file_size
      t.string :path
      t.integer :uploaded_size, default: 0
      t.datetime :expiry_date
      t.boolean :mail_sent, default: false
      t.integer :sender_id
      t.integer :receiver_id 
      t.boolean :is_expired
      t.timestamps
    end
  end
end
