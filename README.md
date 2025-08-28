
#### 1. users テーブル
ユーザー情報を管理するテーブル

| Column             | Type     | Options                   |
|--------------------|----------|---------------------------|
| id                 | integer  | PRIMARY KEY               |
| nickname           | string   | null: false               |
| email              | string   | null: false, unique: true |
| encrypted_password | string   | null: false, default: ""  |
| last_name          | string   | null: false               |
| first_name         | string   | null: false               |
| last_name_kana     | string   | null: false               |
| first_name_kana    | string   | null: false               |
| birth_day          | date     | null: false               |
| created_at         | datetime | null: false               |
| updated_at         | datetime | null: false               |

## アソシエーション
# User
 has_many :products
 has_many :orders


#### 2. products テーブル
商品情報を管理するテーブル

| Column           | Type       | Options                        |
|------------------|------------|--------------------------------|
| id               | integer    | PRIMARY KEY                    |
| user             | references | null: false, foreign_key: true |
| name             | string     | null: false                    |
| description      | text       | null: false                    |
| category_id      | integer    | null: false                    |
| status_id        | integer    | null: false                    |
| shipping_cost_id | integer    | null: false                    |
| prefecture_id    | integer    | null: false                    |
| shipping_day_id  | integer    | null: false                    |
| price            | integer    | null: false                    |
| created_at       | datetime   | null: false                    |
| updated_at       | datetime   | null: false                    |

## アソシエーション
# Product
 belongs_to :user
 has_one :order

#### 3. orders テーブル
注文情報を管理するテーブル

| Column     | Type       | Options                        |
|------------|------------|--------------------------------|
| id         |  integer   | PRIMARY KEY                    |
| user       | references | null: false, foreign_key: true |
| product    | references | null: false, foreign_key: true |
| created_at | datetime   | null: false                    |
| updated_at | datetime   | null: false                    |

## アソシエーション
# Order
 belongs_to :user
 belongs_to :product
 has_one    :address


#### 4. addresses テーブル
配送先住所情報を管理するテーブル

| Column        | Type       | Options                         |
|---------------|------------|---------------------------------|
| id            |  integer   | PRIMARY KEY                     |
| order         | references | null: false, foreign_key: true  |
| postal_code   | string     | null: false                     |
| prefecture_id | integer    | null: false                     |
| city          | string     | null: false                     |
| block         | string     | null: false                     |
| building      | string     |                                 |
| phone_number  | string     | null: false                     |
| created_at    | datetime   | null: false                     |
| updated_at    | datetime   | null: false                     |

## アソシエーション
# Address
 belongs_to :order




