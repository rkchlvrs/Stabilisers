class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation
  
  EmailRegex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  # name and email confirmations
  validates_presence_of :name, :email
  validates_length_of :name, :maximum => 50
  
  validates_format_of :email, :with => EmailRegex
  validates_uniqueness_of :email, :case_sensitive => false
  
  # password validations
  validates_confirmation_of :password
  validates_presence_of :password
  validates_length_of :password, :within => 6..40  
  
  before_save :encrypt_password
  
  private
  
    def encrypt_password
      # same as ... = encrypt(self.password)
      self.encrypted_password = encrypt(password)
    end
    
    def encrypt(string)
      string
    end
end
