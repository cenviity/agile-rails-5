require 'test_helper'

class CartTest < ActiveSupport::TestCase
  setup do
    @cart = carts(:empty_cart)
    @ruby = products(:ruby)
    @other_product = products(:one)
  end
  
  test "should add unique product as separate line item" do
    @cart.add_product(@ruby).save!
    @cart.add_product(@other_product).save!
    
    assert_equal 2, @cart.line_items.size
    assert_equal 59.49, @cart.total_price
  end
  
  test "should add duplicate product to existing line item" do
    2.times { @cart.add_product(@ruby).save! }
    
    assert_equal 1, @cart.line_items.size
    assert_equal 2, @cart.line_items.first.quantity
    assert_equal 99, @cart.total_price
  end
end
