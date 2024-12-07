class Order < ApplicationRecord
  belongs_to :user
  has_many :line_items, dependent: :destroy
  
  validates :status, presence: true
  validates :address, presence: true
  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :payment_type, presence: true
  
  PAYMENT_TYPES = ['Credit Card', 'PayPal', 'Bank Transfer']
  
  enum :status, {
    pending: 'pending',
    shipped: 'shipped',
    completed: 'completed',
    cancelled: 'cancelled'
  }, default: 'pending'
  
  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      item.price ||= item.product.price
      line_items << item
    end
  end
  
  def total_price
    line_items.sum { |item| item.total_price }
  end
end