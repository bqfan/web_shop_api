class OrderItem < ActiveRecord::Base
  belongs_to :order, inverse_of: :order_items
  belongs_to :product, inverse_of: :order_items

	after_create :decrement_product_stock!

  def decrement_product_stock!
    self.product.decrement!(:stock, quantity)
  end
end
