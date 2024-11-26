class User < ApplicationRecord
  
  before_validation :strip_extra_spaces
  
  validates :name, presence :true
  validates :email,
    format: {with URI::MailTo::EMAIL_REGEXP},
    uniqueness: {case_sensitive: false}
  validates :password,
    presence :true,
    length: {minimum: 8}
  has_secure_password
  
    
  has_many :memberships, dependent: :destroy
  has_many :organizations, through: :memberships
  
  private
  
  def strip_extra_spaces
    self.name = self.name&.strip
    self.email = self.email&.strip
  end
    
end
