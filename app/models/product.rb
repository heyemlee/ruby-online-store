class Product < ApplicationRecord
    has_many :line_items
    
    validates :name, presence: true
    validates :price, presence: true, numericality: { greater_than_or_equal_to: 0.01 }
    validates :description, presence: true
    validates :image_url, presence: true
  end