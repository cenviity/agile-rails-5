class Order < ApplicationRecord
  belongs_to :payment_type
  has_many :line_items, dependent: :destroy
  
  validates :name, :address, :email, presence: true
  validates :payment_type, inclusion: { in: PaymentType.all }
  
  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
end
