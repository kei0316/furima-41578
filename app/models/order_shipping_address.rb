class OrderShippingAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :address_line, :building_name, :phone_number, :token

  # バリデーションの追加
  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: "must be in the format 123-4567" }
    validates :prefecture_id, numericality: { other_than: 1, message: "を選択してください" }
    validates :city
    validates :address_line
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: "must be 10 to 11 digits" }
    validates :token
  end

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
end
