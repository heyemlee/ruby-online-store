class LineItem < ApplicationRecord
  belongs_to :cart, optional: true
  belongs_to :product
  belongs_to :order, optional: true

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :price, presence: true, numericality: { greater_than: 0 }

  before_save :ensure_price

  def total_price
    price * quantity
  end

  private

  def ensure_price
    self.price ||= product.price
  end
end