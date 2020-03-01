class Merchant::DiscountsController < Merchant::BaseController
  def index
    @discounts = Discount.all
  end

  def new
    @merchant = Merchant.find(current_user.merchant_id)
  end

  def create
    @merchant = Merchant.find(current_user.merchant_id)
    discount = @merchant.discounts.create(discount_params)
    discount.item_id = params[:item][:item_id]
    if discount.save
      flash[:success] = "#{discount.name} Created Successfully"
      redirect_to "/merchant/discounts"
    else
      flash[:error] = discount.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @discount = Discount.find(params[:id])
  end

  def update
    @discount = Discount.find(params[:id])
    @discount.update(discount_params)
    if @discount.save
      flash[:success] = "#{@discount.name} Updated Successfully"
      redirect_to "/merchant/discounts"
    else
      flash[:error] = @discount.errors.full_messages.to_sentence
      redirect_to "/merchant/discounts/#{@discount.id}/edit"
    end
  end

  def destroy
    Discount.destroy(params[:id])
    redirect_to '/merchant/discounts'
  end


  private

  def discount_params
    params.permit(:name, :quantity_required, :percentage, :item)
  end

end
