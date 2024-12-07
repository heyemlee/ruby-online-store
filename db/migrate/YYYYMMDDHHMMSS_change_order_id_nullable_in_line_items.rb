class ChangeOrderIdNullableInLineItems < ActiveRecord::Migration[7.1]
  def change
    change_column_null :line_items, :order_id, true
  end
end 