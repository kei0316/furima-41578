class ItemsController < ApplicationController
  before_action :authenticate_user!,except: [:index, :show]

  def index
    @items = Item.order(created_at: :desc)
  end  

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to items_path, notice: "商品が正常に出品されました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @item = Item.find(params[:id])
  end


  private

  def item_params
    params.require(:item).permit(:name, :description, :image, :category_id, :condition_id, :shipping_cost_id, :prefecture_id, :shipping_day_id, :price).merge(user_id: current_user.id)
  end
end
