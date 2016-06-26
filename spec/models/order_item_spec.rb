require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  let(:order_item) { FactoryGirl.build :order_item }
  subject { order_item }

  it { is_expected.to respond_to :order_id }
  it { is_expected.to respond_to :product_id }

  it { is_expected.to belong_to :order }
  it { is_expected.to belong_to :product }
  it { is_expected.to respond_to :product_id }
  it { is_expected.to respond_to :quantity }

  describe "#decrement_product_stock!" do
    it "decreases the product stock by the order item quantity" do
      product = order_item.product
      expect{order_item.decrement_product_stock!}.to change{product.stock}.by(-order_item.quantity)
    end
  end
end

