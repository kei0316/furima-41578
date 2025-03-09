class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item, only: [:index, :create]
  before_action :check_owner, only: [:index, :create]
  before_action :check_sold_out, only: [:index, :create]  # 追加

  def index
    if @item.present?
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      @order_shipping_address = OrderShippingAddress.new(user_id: current_user.id, item_id: @item.id)
    else
      redirect_to root_path
    end
  end

  def create
    if @item.present?
      @order_shipping_address = OrderShippingAddress.new(order_shipping_address_params)
      if @order_shipping_address.save
        pay_item
        redirect_to root_path, notice: 'Order was successfully created.'
      else
        gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
        render :index, status: :unprocessable_entity
      end
    else
      redirect_to root_path
    end
  end

  private

  def set_item
    @item = Item.find_by(id: params[:item_id])
    unless @item
      redirect_to root_path
    end
  end

  def check_owner
    if @item.user_id == current_user.id
      redirect_to root_path
    end
  end

  def check_sold_out
    if @item.sold_out?
      redirect_to root_path
    end
  end

  def order_shipping_address_params
    params.require(:order_shipping_address).permit(
      :user_id, :item_id, :postal_code, :prefecture_id, :city, :address_line, :building_name, :phone_number
    ).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: order_shipping_address_params[:token],
      currency: 'jpy'
    )
  end
end
