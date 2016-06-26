class EnoughProductsValidator < ActiveModel::Validator
  def validate(record)
    record.order_items.each do |order_item|
      product = order_item.product
      if order_item.quantity > product.stock
        record.errors["#{product.name}"] << "Is out of stock, just #{product.stock} left"
      end
    end
  end
end