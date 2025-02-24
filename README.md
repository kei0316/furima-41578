# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| last_name          | string | null: false               |
| first_name         | string | null: false               |
| last_name_kana     | string | null: false               |
| first_name_kana    | string | null: false               |
| birthdate          | date   | null: false               |

### Association

- has_many :orders
- has_many :items

## items テーブル

| Column           | Type    | Options                        |
| -----------------| ------- | ------------------------------ |
| name             | string  | null: false, foreign_key: true |
| description      | text    | null: false, foreign_key: true |
| category_id      | integer | null: false, foreign_key: true |
| condition_id     | integer | null: false, foreign_key: true |
| shipping_cost_id | integer | null: false, foreign_key: true |
| prefecture_id    | integer | null: false, foreign_key: true |
| shipping_day_id  | integer | null: false, foreign_key: true |
| price            | integer | null: false, foreign_key: true |

### Association

belongs_to : user 
has_one : order

## orders テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| items  | references | null: false, foreign_key: true |

### Association

belongs_to :user
belongs_to :item
has_one :shipping_address

## shipping_addresses テーブル

| Column         | Type       | Options                        |
| -------------- | -----------| ------------------------------ |
| postal_code    | string     | null: false                    |
| prefecture_id  | integer    | null: false                    |
| city           | string     | null: false                    |
| address_line   | string     | null: false                    |
| building_name  | string     |                                |
| phone_number   | string     | null: false                    |
| order          | references | null: false,foreign_key: true  |

### Association

belongs_to :order