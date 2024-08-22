# テーブル設計

## users テーブル

| Column           | Type   | Options     |
| ---------------- | ------ | ----------- |
| nickname         | string | null: false |
| email            | string | null: false, unique: true |
| confirm_password | string | null: false |
| last_name        | string | null: false |
| first_name       | string | null: false |
| last_name_kana   | string | null: false |
| first_name_kana  | string | null: false |
| birth_year       | string | null: false |
| birth_month      | string | null: false |
| birth_date       | string | null: false |

### Association

- has_many :items
- has_many :orders

## items テーブル

| Column          | Type       | Options     |
| --------------- | ---------- | ----------- |
| item_name       | string     | null: false |
| description     | text       | null: false |
| item_category   | string     | null: false |
| item_status     | string     | null: false |
| shipping_burden | string     | null: false |
| shipping_origin | string     | null: false |
| shipping_date   | string     | null: false |
| price           | integer    | null: false |
| user            | references | null: false ,foreign_key: true |

### Association

- belongs_to :user
- has_one :order

## orders テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- belongs_to :shipping_address

## shipping_addresses テーブル

| Column        | Type       | Options     |
| ------------- | ---------- | ------------|
| portal_code   | string     | null: false |
| prefecture    | string     | null: false |
| city          | string     | null: false |
| street_address| string     | null: false |
| building_name | string     | null: false |
| phone_number  | string     | null: false |
| user          | references | null: false, foreign_key: true |
| item          | references | null: false, foreign_key: true |

### Association

- belongs_to :order