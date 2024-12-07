class FixLineItemsConstraints < ActiveRecord::Migration[7.1]
  def change
    # 先删除外键约束
    remove_foreign_key :line_items, :orders
    remove_foreign_key :line_items, :carts
    
    # 修改列允许为空
    change_column_null :line_items, :order_id, true
    change_column_null :line_items, :cart_id, true
    
    # 重新添加外键约束
    add_foreign_key :line_items, :orders
    add_foreign_key :line_items, :carts
  end
end 