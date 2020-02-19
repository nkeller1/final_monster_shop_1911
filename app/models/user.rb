class User < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip, :password
  validates :email, presence: true, uniqueness: true
  has_secure_password
end
