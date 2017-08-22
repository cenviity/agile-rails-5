class AddPaymentTypeToOrder < ActiveRecord::Migration[5.0]
  def up
    add_reference :orders, :payment_type, foreign_key: true
    
    Order.all.each do |order|
      order.update(payment_type_id:
        case order.pay_type
        when 'Check'          then 1
        when 'Credit card'    then 2
        when 'Purchase order' then 3
        end
      )
    end
    
    remove_column :orders, :pay_type
  end
  
  def down
    add_column :orders, :pay_type, :integer
    
    Order.all.each do |order|
      order.update(pay_type:
        case order.payment_type
        when 1 then 'Check'
        when 2 then 'Credit card'
        when 3 then 'Purchase order'
        end
      )
    end
    
    remove_reference :orders, :payment_type
  end
end
