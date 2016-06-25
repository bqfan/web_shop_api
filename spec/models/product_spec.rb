require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product) { FactoryGirl.build :product }
  subject { product }

  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:price) }
  it { is_expected.to respond_to(:stock) }
  it { is_expected.to respond_to(:published) }
  it { is_expected.to respond_to(:user_id) }

  it { is_expected.not_to be_published }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :price }
  it { is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
  it { is_expected.to validate_presence_of :stock }
  it { is_expected.to validate_numericality_of(:stock).is_greater_than_or_equal_to(0) }

  it { is_expected.to validate_presence_of :user_id }

  it { is_expected.to belong_to :user }

  describe ".filter_by_name" do
    before(:each) do
      @product1 = FactoryGirl.create :product, name: "A plasma TV"
      @product2 = FactoryGirl.create :product, name: "Fastest Laptop"
      @product3 = FactoryGirl.create :product, name: "CD player"
      @product4 = FactoryGirl.create :product, name: "LCD TV"
    end

    context "when a 'TV' title pattern is sent" do
      it "returns the 2 products matching" do
        expect(Product.filter_by_name("TV").length).to eq(2)
      end

      it "returns the products matching" do
        expect(Product.filter_by_name("TV").sort).to match_array([@product1, @product4])
      end
    end
  end

  describe ".above_or_equal_to_price" do
    before(:each) do
      @product1 = FactoryGirl.create :product, price: 100
      @product2 = FactoryGirl.create :product, price: 50
      @product3 = FactoryGirl.create :product, price: 150
      @product4 = FactoryGirl.create :product, price: 99
    end

    it "returns the products which are above or equal to the price" do
      expect(Product.above_or_equal_to_price(100).sort).to match_array([@product1, @product3])
    end
  end

  describe ".below_or_equal_to_price" do
    before(:each) do
      @product1 = FactoryGirl.create :product, price: 100
      @product2 = FactoryGirl.create :product, price: 50
      @product3 = FactoryGirl.create :product, price: 150
      @product4 = FactoryGirl.create :product, price: 99
    end

    it "returns the products which are above or equal to the price" do
      expect(Product.below_or_equal_to_price(99).sort).to match_array([@product2, @product4])
    end
  end

  describe ".order_by_name" do
    before(:each) do
      @product1 = FactoryGirl.create :product, name: "A plasma TV"
      @product2 = FactoryGirl.create :product, name: "Fastest Laptop"
      @product3 = FactoryGirl.create :product, name: "CD player"
      @product4 = FactoryGirl.create :product, name: "LCD TV"

      # Touch some products to update them
      @product2.touch
      @product3.touch
    end

    it "returns the records ordered by name" do
      expect(Product.order_by_name).to match_array([@product1, @product3, @product2, @product4])
    end
  end

  describe ".order_by_price" do
    before(:each) do
      @product1 = FactoryGirl.create :product, name: "A plasma TV"
      @product2 = FactoryGirl.create :product, name: "Fastest Laptop"
      @product3 = FactoryGirl.create :product, name: "CD player"
      @product4 = FactoryGirl.create :product, name: "LCD TV"
    end

    it "returns the records ordered by price" do
      expect(Product.order_by_name).to match_array([@product2, @product4, @product1, @product3])
    end
  end

  describe ".page" do
    before(:each) do
      58.times { FactoryGirl.create :product }
    end

    it "returns the records 5 records per page" do
      expect(Product.page(1).count).to eq(25)
      expect(Product.page(2).count).to eq(25)
      expect(Product.page(3).count).to eq(8)
    end
  end
end
