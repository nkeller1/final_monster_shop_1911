class User < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip
  validates :email, presence: true, uniqueness: true
  validates :password, confirmation: { presence: true, case_sensitive: true }

  has_many :orders
  has_secure_password

  enum role: %w(default_user merchant_user admin_user)

  def has_order?
    self.orders.count > 0
  end
end
