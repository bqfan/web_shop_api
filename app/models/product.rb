class Product < ActiveRecord::Base
  validates_presence_of :name, :price, :stock, :user_id
  validates_numericality_of :price, greater_than_or_equal_to: 0
  validates_numericality_of :stock, greater_than_or_equal_to: 0
end
