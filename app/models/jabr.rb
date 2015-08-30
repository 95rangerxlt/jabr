class Jabr < ActiveRecord::Base
  belongs_to :sender, class_name: "User", :foreign_key => :sender_id
  belongs_to :recipient, class_name: "User", :foreign_key => :recipient_id
  has_many :messages, dependent: :destroy

  validates_uniqueness_of :sender_id, :scope => :recipient_id

  scope :between, -> (sender_id,recipient_id) do
    where("(jabrs.sender_id = ? AND jabrs.recipient_id =?) OR (jabrs.sender_id = ? AND jabrs.recipient_id =?) ", sender_id,recipient_id, recipient_id, sender_id)
  end

end
