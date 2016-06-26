class Product < ActiveRecord::Base
	paginates_per 25

	belongs_to :user
  has_many :order_items
  has_many :orders, through: :order_items

  validates_presence_of :name, :price, :stock, :user_id
  validates_numericality_of :price, greater_than_or_equal_to: 0
  validates_numericality_of :stock, greater_than_or_equal_to: 0

	scope :filter_by_name, lambda { |keyword|
    where("lower(name) LIKE ?", "%#{keyword.downcase}%" ) 
 	}

  scope :above_or_equal_to_price, lambda { |price| 
    where("price >= ?", price) 
  }

  scope :below_or_equal_to_price, lambda { |price| 
    where("price <= ?", price) 
  }

  scope :order_by_name, -> {
    order(:name)
  }

  scope :order_by_price, -> {
    order(:price)
  }

  def self.search(params = {})
    products = params[:product_ids].present? ? Product.find(params[:product_ids]) : Product.all

    products = products.filter_by_name(params[:keyword]) if params[:keyword]
    products = products.above_or_equal_to_price(params[:min_price].to_f) if params[:min_price]
    products = products.below_or_equal_to_price(params[:max_price].to_f) if params[:max_price]
    products = products.order_by_name if params[:order_by_name].present?
    products = products.order_by_price if params[:order_by_price].present?
    products = products.page(params[:page]) if params[:page].present?

    products
  end
end
