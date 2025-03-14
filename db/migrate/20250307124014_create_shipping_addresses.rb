class CreateShippingAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :shipping_addresses do |t|
      t.string     :postal_code,    null: false
      t.integer    :prefecture_id,  null: false
      t.string     :city,           null: false
      t.string     :address_line,   null: false
      t.string     :building_name
      t.string     :phone_number,   null: false
      t.references :order, foreign_key: true, null: false
      t.timestamps
    end
  end
end
