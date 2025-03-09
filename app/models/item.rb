class Item < ApplicationRecord
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :shipping_cost
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :shipping_day

  belongs_to :user
  has_one :order  # 修正

  validates :name, :image, :description, :category_id, :condition_id, :shipping_cost_id, :prefecture_id, :shipping_day_id, :price, presence: true
  validates :category_id, :condition_id, :shipping_cost_id, :prefecture_id, :shipping_day_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, only_integer: true }

  # 売却済みかどうかを確認するメソッド
  def sold_out?
    order.present?
  end
end
