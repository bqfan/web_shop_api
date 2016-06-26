class Order < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :total
  validates_numericality_of :total, greater_than_or_equal_to: 0

  validates_presence_of :user_id

  has_many :order_items
  has_many :products, through: :order_items
end
