FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.paragraph }
    price { Faker::Number.between(from: 300, to: 9_999_999) }
    category_id { Faker::Number.between(from: 2, to: 11) }
    status_id { Faker::Number.between(from: 2, to: 7) }
    shipping_cost_id { Faker::Number.between(from: 2, to: 3) }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    shipping_day_id { Faker::Number.between(from: 2, to: 4) }
    association :user

    after(:build) do |item|
      # テスト用のダミー画像を作成
      item.image.attach(
        io: StringIO.new('dummy image content'),
        filename: 'test_image.jpg',
        content_type: 'image/jpeg'
      )
    end
  end
end
