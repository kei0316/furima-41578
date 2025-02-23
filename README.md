# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false, unique: true |
| password           | string | null: false |
| full_name          | string | null: false |
| kana_name          | string | null: false |
| birthdate          | date | null: false |

### Association

- has_many :orders
- has_many :items

## items テーブル

| Column           | Type   | Options     |
| -----------------| ------ | ----------- |
| image            | binary | null: false |
| name             | string | null: false |
| description      | string | null: false |
| category         | string | null: false |
| condition        | string | null: false |
| shipping_cost    | string | null: false |
| shipping_origin  | string | null: false |
| shipping_days    | string | null: false |
| price            | integer | null: false |

### Association

belongs_to : user 
has_one : order

## orders テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user_id   | string | null: false, foreign_key: true |
| items_id  | string | null: false, foreign_key: true |

### Association

belongs_to :user
belongs_to :item
has_one :shipping_address

## shipping_addresses テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| postal_code    | string | null: false  |
| prefecture    | string | null: false  |
| city    | string | null: false  |
| address_line    | string | null: false  |
| building_name    | string |  null: true     |
| phone_number    | string | null: false  |
| order_id    | integer | null: false,foreign_key: true  |

### Association

belongs_to :order