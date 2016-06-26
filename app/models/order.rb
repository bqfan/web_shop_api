class Order < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user_id

  has_many :order_items
  has_many :products, through: :order_items

  before_validation :set_total!

	def set_total!
	  self.total = products.map(&:price).sum
	end

end
