FactoryGirl.define do
  factory :product do
    name { FFaker::Product.product_name }
    price { rand() * 100 }
    stock { rand(1..200) } 
    published false
    user
  end
end
