class FixLineItemsTable < ActiveRecord::Migration[7.1]
  def change
    # 先删除表
    drop_table :line_items, if_exists: true

    # 重新创建表，确保正确的约束
    create_table :line_items do |t|
      t.references :product, null: false, foreign_key: true
      t.references :cart, null: true, foreign_key: true
      t.references :order, null: true, foreign_key: true  # 明确设置 null: true
      t.integer :quantity, default: 1
      t.decimal :price, precision: 8, scale: 2

      t.timestamps
    end
  end
end 