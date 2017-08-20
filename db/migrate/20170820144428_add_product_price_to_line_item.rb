class AddProductPriceToLineItem < ActiveRecord::Migration[5.0]
  def change
    add_column :line_items, :price, :decimal, precision: 8, scale: 2
    
    LineItem.all.each do |item|
      item.update(price: item.product.price)
    end
  end
end
