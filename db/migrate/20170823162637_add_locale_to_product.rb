class AddLocaleToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :locale, :string
    
    Product.all.each do |product|
      product.update(locale: 'en')
    end
  end
end
