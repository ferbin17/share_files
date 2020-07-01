class AddDeleteMailToFileSender < ActiveRecord::Migration[6.0]
  def change
    add_column :file_senders, :sender_delete_mail_sent, :boolean, default: false
    add_column :file_senders, :receiver_delete_mail_sent, :boolean, default: false
  end
end
