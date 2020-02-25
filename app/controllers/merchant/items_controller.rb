class Merchant::ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(current_user.merchant_id)
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @merchant = Merchant.find(current_user.merchant_id)
  end

  def create
    @merchant = Merchant.find(current_user.merchant_id)
    item = @merchant.items.create(item_params)
    if item.save
      flash[:success] = "#{item.name} Created Successfully"
      redirect_to "/merchant/items"
    else
      flash[:error] = item.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    if @item.save
      flash[:success] = "#{@item.name} Updated Successfully"
      redirect_to merchant_item_path(@item.id)
    else
      flash[:error] = @item.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    item = Item.find(params[:id])
    Review.where(item_id: item.id).destroy_all
    item.destroy
    flash[:success] = "This item is now deleted."
    redirect_to "/merchant/items"
  end

  def activate_deactivate_item
    item = Item.find(params[:item_id])
    if item.active?
      item.update(active?: false)
      flash[:disabled] = "#{item.name} has been Deactivated"
    else
      item.update(active?: true)
      flash[:enabled] = "#{item.name} has been Activated"
    end
    redirect_to '/merchant/items'
  end

  private

  def item_params
    params.permit(:name,:description,:price,:inventory,:image)
  end
end
