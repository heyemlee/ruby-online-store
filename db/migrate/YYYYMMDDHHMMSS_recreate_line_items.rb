class RecreateLineItems < ActiveRecord::Migration[7.1]
  def up
    # 先删除现有表
    drop_table :line_items if table_exists?(:line_items)
    
    # 重新创建表
    create_table :line_items do |t|
      t.references :product, null: false, foreign_key: true
      t.references :cart, foreign_key: true
      t.references :order, foreign_key: true, null: true
      t.integer :quantity, default: 1
      t.decimal :price, precision: 8, scale: 2

      t.timestamps
    end
  end

  def down
    drop_table :line_items
  end
end 