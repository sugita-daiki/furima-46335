
#### 1. users テーブル
ユーザー情報を管理するテーブル

| Column             | Type     | Options                   |
|--------------------|----------|------|------------------- |
| id                 | integer  | PRIMARY KEY               |
| nickname           | string   | null: false               |
| email              | string   | null: false, unique: true |
| encrypted_password | string   | null: false,default: ""   |
| last_name          | string   | null: false               |
| first_name         | string   | null: false               |
| last_name_kana     | string   | null: false               |
| first_name_kana    | string   | null: false               |
| birth_day          | date     | null: false               |
| created_at         | datetime | NOT NULL                  |
| updated_at         | datetime | NOT NULL                  |

## アソシエーション
# User
 has_many :products
 has_many :orders


#### 2. products テーブル
商品情報を管理するテーブル

| Column           | Type       | Options                        |
|------------------|------------|------------------------------- |
| id               | integer    |                                |
| user_id          | references | null: false, foreign_key: true |
| name             | string     | null: false                    |
| description      | text       | null: false                    |
| category_id      | references | null: false, foreign_key: true |
| status_id        | references | null: false, foreign_key: true |
| shipping_cost_id | references | null: false, foreign_key: true |
| shipping_area_id | references | null: false, foreign_key: true |
| shipping_days_id | references | null: false, foreign_key: true |
| price            | integer    | null: false                    |
| fee              | integer    | null: false                    |
| profit           | integer    | null: false                    |
| created_at       | datetime   | NOT NULL                       |
| updated_at       | datetime   | NOT NULL                       |

## アソシエーション
# Product
 belongs_to :user
 has_one :order
 belongs_to :category
 belongs_to :status
 belongs_to :shipping_cost
 belongs_to :shipping_area
 belongs_to :shipping_days

#### 3. orders テーブル
注文情報を管理するテーブル

| Column     | Type       | Options                        |
|-------------|-----------|--------------------------------|
| id         | integer    | PRIMARY KEY                    |
| user_id    | references | null: false, foreign_key: true |
| product_id | references | null: false, foreign_key: true |
| created_at | datetime   | NOT NULL                       |
| updated_at | datetime   | NOT NULL                       |

## アソシエーション
# Order
 belongs_to :user
 belongs_to :product
 has_one    :address


#### 4. addresses テーブル
配送先住所情報を管理するテーブル

| Column        | Type       | Options                         |
|---------------|--------    |---------------------------------|
| id            |  integer   | PRIMARY KEY                     |
| order_id      | references | null: false, foreign_key: true. |
| postal_code   | string     | null: false                     |
| prefecture_id | integer    | null: false                     |
| city          | string     | null: false                     |
| block         | string     | null: false                     |
| building      | string     |                                 |
| phone_number  | string     | null: false                     |
| created_at    | datetime   | NOT NULL                        |
| updated_at    | datetime   | NOT NULL                        |

## アソシエーション
# Address
 belongs_to :order

### ActiveHash 

#### 1. categories (ActiveHash)
商品カテゴリを管理

| Column | Type   | Options     |
|--------|--------|-------------|
| id     | integer| null: false |
| name   | string | null: false |

## Association
 has_many :products

- レディース
- メンズ
- 子供用品
- インテリア
- 本・音楽・ゲーム
- おもちゃ・ホビー・グッズ
- 家電・スマホ・カメラ
- スポーツ・レジャー
- ハンドメイド
- チケット
- 自動車・オートバイ
- その他

#### 2. statuses (ActiveHash)
商品状態を管理

| Column | Type   | Options     |
|--------|--------|-------------|
| id     | integer| null: false |
| name   | string | null: false |

## Association
 has_many :products

- 新品・未使用
- 未使用に近い
- 目立った傷や汚れなし
- やや傷や汚れあり
- 傷や汚れあり
- 全体的に状態が悪い

#### 3. shipping_costs (ActiveHash)
配送料負担を管理

| Column | Type   | Options     |
|--------|--------|-------------|
| id     | integer| null: false |
| name   | string | null: false |

## Association
 has_many :products

- 着払い(購入者負担)
- 送料込み(出品者負担)

#### 4. shipping_areas (ActiveHash)
発送元地域を管理

| Column | Type   | Options     |
|--------|--------|-------------|
| id     | integer| null: false |
| name   | string | null: false |

## Association
 has_many :products

- 北海道、青森県、岩手県、宮城県、秋田県、山形県
- 福島県、茨城県、栃木県、群馬県、埼玉県、千葉県
- 東京都、神奈川県、新潟県、富山県、石川県、福井県
- 山梨県、長野県、岐阜県、静岡県、愛知県、三重県
- 滋賀県、京都府、大阪府、兵庫県、奈良県、和歌山県
- 鳥取県、島根県、岡山県、広島県、山口県、徳島県
- 香川県、愛媛県、高知県、福岡県、佐賀県、長崎県
- 熊本県、大分県、宮崎県、鹿児島県、沖縄県、未定

#### 5. shipping_days (ActiveHash)
発送日数を管理

| Column | Type   | Options     |
|--------|--------|-------------|
| id     | integer| null: false |
| name   | string | null: false |

## Association
 has_many :products

- 1~2日で発送
- 2~3日で発送
- 4~7日で発送

