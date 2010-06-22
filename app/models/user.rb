# == Schema Information
# Schema version: 20100618055959
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#
require 'digest'

class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation

  validates_presence_of :name, :email, :password
  validates_length_of :name, :maximum => 50
  validates_uniqueness_of :email
  validates_confirmation_of :password
  validates_length_of :name, :within => 5..40
  before_save :encrypt_password

  def has_password?(submitted_password)
    self.encrypted_password == encrypt(submitted_password)
  end
  
  def self.authenticate(email, submitted_password)
    user = self.find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end
  
  def remember_me!
    self.remember_token = secure_hash("#{self.salt}--#{self.id}--#{Time.now.utc}")
    save_without_validation
  end

  def forget_me!
    self.remember_token = nil
    save_without_validation
  end
  
  private
  
    def encrypt_password
      unless self.password.nil?
        self.salt = make_salt
        self.encrypted_password = encrypt(self.password)
      end
    end
  
    def encrypt (string)
      secure_hash("#{self.salt}#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}#{self.password}")
    end
    
    def secure_hash (string)
      Digest::SHA2.hexdigest(string)      
    end
      
end
