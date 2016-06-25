class Product < ActiveRecord::Base
	paginates_per 25

	belongs_to :user

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

end
