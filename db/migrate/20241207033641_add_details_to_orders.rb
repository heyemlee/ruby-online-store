class AddDetailsToOrders < ActiveRecord::Migration[8.0]
  def change
    add_column :orders, :name, :string
    add_column :orders, :email, :string
    add_column :orders, :payment_type, :string
  end
end
