class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :stock, :published

  belongs_to :user
end
