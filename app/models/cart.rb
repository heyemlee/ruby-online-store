class Cart < ApplicationRecord
    has_many :line_items, dependent: :destroy

    def add_product(product)
        current_item = line_items.find_by(product_id: product.id)
        
        if current_item
            current_item.quantity += 1
            current_item.save
        else
            current_item = line_items.create!(
                product_id: product.id,
                quantity: 1,
                price: product.price,
                order_id: nil
            )
        end
        current_item
    end

    def total_price
        line_items.sum { |item| item.total_price }
    end
end