class UsersController < ApplicationController
  before_action :set_user, only: [:show,:edit, :update, :destroy]
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update, :destroy]
    

  def index
    @users= User.all.paginate(page: params[:page], per_page: 3)
  end

  def new 
    @user= User.new
  end

  def create 
    
    @user=User.new(user_params)

    if  @user.save
      session[:user_id] = @user.id
      flash[:notice] ="#{(current_user.first_name + ' ' + current_user.last_name).capitalize()} has been successfully created."
      redirect_to user_path(@user)
    else
      render 'new'
    end

  end
  
  def show
   
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "#{(current_user.first_name + ' ' + current_user.last_name).capitalize()} Info has been updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    @user.destroy
    session[:user_id] =  nil if @user ==current_user
    flash[:notice] = "The Furnico account #{(@user.first_name + @user.last_name).capitalize()} has been deleted and cart items have been cleared."
    redirect_to users_path 
  end

  

  def add_to_cart
    @add_to_cart_product= Product.find_by(:id => params[:product_id])
    if logged_in?
      current_user.products << @add_to_cart_product
      flash[:alert] = "#{@add_to_cart_product.ProductName} has been added to your cart."
      redirect_to user_path(current_user)
    else
      # current user is nil and not logged in
      flash[:notice ] = "Please login to add items to cart."
      redirect_to login_show_login_path

    end
  end

  def remove_from_cart
    @remove_from_cart_product= Product.find_by(:id => params[:product_id])
    if logged_in?
      current_user.products.delete(@remove_from_cart_product.id)
      flash[:alert] = "#{@remove_from_cart_product.ProductName} has been removed from your cart."
      redirect_to user_path(current_user)
    else
      flash[:notice ] = "Please login to remove items from cart."
      redirect_to login_show_login_path
    end
  end
  
  private 
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email , :password )
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:alert] = "You can edit your own account."
      redirect_to @user
    end
  end
end
