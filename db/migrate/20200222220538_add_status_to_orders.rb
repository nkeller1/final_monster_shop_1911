class AddStatusToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :status, :integer, default: 1
  end
end
