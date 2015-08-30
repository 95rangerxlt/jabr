class User < ActiveRecord::Base
  include BCrypt

  has_many :messages
  has_many :jabrs, :foreign_key => :sender_id
  has_many :jabrs, :foreign_key => :recipient_id


  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
