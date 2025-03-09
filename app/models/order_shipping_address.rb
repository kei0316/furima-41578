class OrderShippingAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :address_line, :building_name, :phone_number,:token

  # バリデーションの追加
  validates :user_id, :item_id, :postal_code, :prefecture_id, :city, :address_line, :phone_number, presence: true
  validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: "must be in the format 123-4567" }
  validates :phone_number, format: { with: /\A\d{10,11}\z/, message: "must be 10 to 11 digits" }
  validate :valid_prefecture
  validates :token, presence: true

  def save
    return false unless valid?

    ActiveRecord::Base.transaction do
      order = Order.create!(user: User.find(user_id), item: Item.find(item_id))
      ShippingAddress.create!(
        order_id: order.id,
        postal_code: postal_code,
        prefecture_id: prefecture_id,
        city: city,
        address_line: address_line,
        building_name: building_name,
        phone_number: phone_number
      )
    end
  rescue ActiveRecord::RecordInvalid => e
    errors.add(:base, e.message)
    false
  end

  private

  def valid_prefecture
    errors.add(:prefecture_id, "を選択してください") if prefecture_id.blank?
  end
end
