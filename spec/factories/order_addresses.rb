FactoryBot.define do
  factory :order_address do
    postal_code { '123-4567' }
    prefecture_id { 2 }
    city { '横浜市' }
    block { '青葉区1-1-1' }
    building {}
    phone_number { '09012345678' }
    token { 'tok_test_token' }
    user_id { 1 }
    item_id { 1 }
  end
end
