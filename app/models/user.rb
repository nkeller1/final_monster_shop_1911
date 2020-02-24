class User < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip
  belongs_to :merchant, optional: true
  validates_presence_of :merchant, if: :merchant_id_present?
  validates :email, presence: true, uniqueness: true
  validates :password, confirmation: { presence: true, case_sensitive: true }

  has_many :orders
  has_secure_password

  enum role: %w(default_user merchant_user admin_user)

  def has_order?
    self.orders.count > 0
  end

  private
    def merchant_id_present?
      merchant_id.present?
    end
end
