class ReviewsController < ApplicationController

  before_action :set_product

  def create
    @review = @product.reviews.new(review_params)
    @review.user_id = current_user.id

    if @review.save
      redirect_to @product
    else
      redirect_to @product
    end

  end

  private

  def review_params
    params.require('review').permit(:rating, :description)
  end

  def set_product
    @product = Product.find(params[:product_id])
    byebug
  end
end
