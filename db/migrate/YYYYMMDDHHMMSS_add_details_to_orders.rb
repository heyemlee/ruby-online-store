class AddDetailsToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :name, :string
    add_column :orders, :email, :string
    add_column :orders, :payment_type, :string
  end
end 