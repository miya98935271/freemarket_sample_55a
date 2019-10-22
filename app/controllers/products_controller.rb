class ProductsController < ApplicationController
  def index
  end

  def new
    @product = Product.new
    @parents = Category.all.order("id ASC").limit(13)
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to users_path, notice: "商品を出品しました"
    else 
      render 'new'
    end
  end

  def buy
  end

  private
  def product_params
    params.require(:product).permit(
      :name,
      :description,
      :category_id,
      :size,
      :condition,
      :postage,
      :shipping_method,
      :prefecture_id,
      :shipping_days,
      :price
    )
  end
  
end
