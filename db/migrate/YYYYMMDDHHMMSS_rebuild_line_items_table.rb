class RebuildLineItemsTable < ActiveRecord::Migration[7.1]
  def up
    # 删除现有的表及其所有约束
    drop_table :line_items if table_exists?(:line_items)

    # 创建新表，确保正确的约束
    create_table :line_items do |t|
      t.references :product, foreign_key: true
      t.references :cart, foreign_key: true
      t.references :order, foreign_key: true
      t.integer :quantity, default: 1
      t.decimal :price, precision: 8, scale: 2

      t.timestamps
    end

    # 添加索引但不添加非空约束
    add_index :line_items, :product_id
    add_index :line_items, :cart_id
    add_index :line_items, :order_id
  end

  def down
    drop_table :line_items
  end
end 