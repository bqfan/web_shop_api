class Order < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user_id
  validates_with EnoughProductsValidator

  has_many :order_items
  has_many :products, through: :order_items

  before_validation :set_total!

	def set_total!
	  self.total = products.map(&:price).sum
	end

  def build_order_items_with_product_ids_and_quantities(product_ids_and_quantities)
    product_ids_and_quantities.each do |product_id_and_quantity|
      id, quantity = product_id_and_quantity # [1,5]

      self.order_items.build(product_id: id, quantity: quantity)
    end
  end
end
