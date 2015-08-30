class CreateJabrs < ActiveRecord::Migration
  def change
    create_table :jabrs do |t|
       t.integer :sender_id
       t.integer :recipient_id

       t.timestamps
     end
  end
end
