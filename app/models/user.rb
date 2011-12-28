
require 'digest/sha2'
class User < ActiveRecord::Base

   attr_accessor :password

   validates :name, :length => {:maximum => 10}


   validates_presence_of :password, :if => :password_required?
   validates_length_of :password, :within => 4..40, :if => :password_required?

   before_save :encrypt_new_password

  # @param login [String]
  # @param password [String]
  def self.authenticate(login, password)
      user = self.find_by_name(login)
      return user if user && user.authenticated(password)
    end

  # @param password [string]
  def authenticated(password)
     hashed_password == encrypt(password)
   end

   protected

     def encrypt_new_password
        return if password.blank?
        self.hashed_password = encrypt password
     end

      def password_required?
        hashed_password.blank? || !password.blank?
      end

      def encrypt(string)
        Digest::SHA2::base64digest(string)
      end



end
