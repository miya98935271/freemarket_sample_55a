class UsersController < ApplicationController
  def index  
  end
  
  def edit
  end

  def logout
  end
  
  def user_identification
  end

  def my_selling_products
    @products = User.find(current_user.id).selling_products.limit(15).order(id: "DESC")
  end

end
