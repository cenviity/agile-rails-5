class CreatePaymentTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :payment_types do |t|
      t.string :name

      t.timestamps
    end
    
    payment_types = ['Check', 'Credit card', 'Purchase order']
    payment_types.each do |payment_type|
      PaymentType.create(name: payment_type)
    end
  end
end
