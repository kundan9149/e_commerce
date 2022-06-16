class ProductsController < ApplicationController
  def show_arrivals
    @arrivals =Product.where(:ProductCategory => "arrival").paginate(page: params[:page], per_page: 3)
  end

  def show_features
    @features = Product.where(ProductCategory: "features").paginate(page: params[:page], per_page: 2)
  end

 
end
