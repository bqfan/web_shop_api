require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { FactoryGirl.build :order }
  subject { order }

  it { is_expected.to respond_to(:total) }
  it { is_expected.to respond_to(:user_id) }

  it { is_expected.to validate_presence_of :user_id }
  it { is_expected.to belong_to :user }

  it { is_expected.to have_many(:order_items) }
  it { is_expected.to have_many(:products).through(:order_items) }

	describe '#set_total!' do
	  before(:each) do
	    product_1 = FactoryGirl.create :product, price: 100
	    product_2 = FactoryGirl.create :product, price: 85

	    @order = FactoryGirl.build :order, product_ids: [product_1.id, product_2.id]
	  end

	  it "returns the total amount to pay for the products" do
	    expect{@order.set_total!}.to change{@order.total}.from(0).to(185)
	  end
	end

  describe "#build_order_items_with_product_ids_and_quantities" do
    before(:each) do
      product_1 = FactoryGirl.create :product, price: 100, stock: 5
      product_2 = FactoryGirl.create :product, price: 85, stock: 10

      @product_ids_and_quantities = [[product_1.id, 2], [product_2.id, 3]]
    end

    it "builds 2 order items for the order" do
      expect{order.build_order_items_with_product_ids_and_quantities(@product_ids_and_quantities)}.to change{order.order_items.size}.from(0).to(2)
    end
  end

  describe "#build_order_items_with_product_ids_and_quantities" do
  end

  describe "#valid?" do
    before do
      product_1 = FactoryGirl.create :product, price: 100, stock: 5
      product_2 = FactoryGirl.create :product, price: 85, stock: 10


      order_item_1 = FactoryGirl.build :order_item, product: product_1, quantity: 3
      order_item_2 = FactoryGirl.build :order_item, product: product_2, quantity: 15

      @order = FactoryGirl.build :order

      @order.order_items << order_item_1
      @order.order_items << order_item_2
    end

    it "becomes invalid due to insufficient products" do
      expect(@order).to_not be_valid
    end
  end
end
