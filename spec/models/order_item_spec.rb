require 'rails_helper'

RSpec.describe OrderItem, type: :model do
	describe OrderItem do
	  let(:order_item) { FactoryGirl.build :order_item }
	  subject { order_item }

	  it { is_expected.to respond_to :order_id }
	  it { is_expected.to respond_to :product_id }

	  it { is_expected.to belong_to :order }
	  it { is_expected.to belong_to :product }
	end
end

