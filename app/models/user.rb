class User < ApplicationRecord
  
  before_save :format_email
  before_create :encrypt_password
  has_many :products
  validates :first_name, presence: true,length: {minimum: 3, maximum:25}
  validates :last_name, presence: true, length: {minimum: 3, maximum:25}
  VALID_EMAIL_REGEX= /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum:125} , uniqueness: {case_sensitive: false} ,format: {with: VALID_EMAIL_REGEX}
  
  require 'bcrypt'
  has_secure_password

  def encrypt_password
    self.password_digest= BCrypt::Password.create(self.password)
  end

  def format_email
    self.email= email.downcase
  end


end
