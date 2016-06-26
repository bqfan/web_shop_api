class ProductSerializer < ActiveModel::Serializer
  cached

  attributes :id, :name, :price, :stock, :published

  has_one :user

  def cache_key
    [object, scope]
  end
end
