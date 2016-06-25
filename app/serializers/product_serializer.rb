class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :stock, :published

  has_one :user
end
