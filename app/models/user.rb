
require 'digest/sha2'
class User < ActiveRecord::Base
   validates :name, :length => {:maximum => 10}
   attr_accessor :password

   validates_presence_of :password, :if => :password_required?
   validates_length_of :password, :within => 4..40, :if => :password_required?

   before_save encrypt_new_password

   def encrypt_new_password
      return if password.blank?
      self.password = encrypt password
   end

  def password_required?
    password.blank? || !password.
  end


end
