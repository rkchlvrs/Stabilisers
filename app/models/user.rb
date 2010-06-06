class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation
  # 1 (short) line for gravatars
  is_gravtastic!
  
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

  # check the user has entered the correct password
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
  
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    user && user.has_password?(submitted_password) ? user : nil
  end
  
  private
  
    def encrypt_password
      self.salt = make_salt
      # same as ... = encrypt(self.password)
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}#{string}")
    end
    
    def make_salt
      secure_hash("#{Time.now.utc}#{password}")
    end
    
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
    
end
