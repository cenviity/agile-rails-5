class AddProductPriceToLineItem < ActiveRecord::Migration[5.0]
  def change
    add_column :line_items, :price, :decimal
  end
end
