class User < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip
  validates :email, presence: true, uniqueness: true
  validates :password, confirmation: { case_sensitive: true }
  has_secure_password

  enum role: %w(default_user merchant_user admin_user)
end
