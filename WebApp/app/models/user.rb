require 'bcrypt'
class User < ActiveRecord::Base
  has_many :preference_sources
  validates_presence_of :name, :email, :encrypted_password
  validates_uniqueness_of :email
  validates_length_of :password, minimum: 6
  validates_confirmation_of :password

  def password=(new_password)
    @password = new_password
    self.encrypted_password = BCrypt::Password.create(@password)
  end

  def password
    @password
  end

  def valid_password? (password_to_validate)
    BCrypt::Password.new(encrypted_password) == password_to_validate
  end
end
