class ReviewsController < ApplicationController

  before_filter :valid_action
  before_action :set_product
  before_action :set_review, :only => :destroy

  def create
    @new_review = @product.reviews.new(review_params)
    @new_review.user_id = current_user.id

    if @new_review.save
      redirect_to @product
    else
      redirect_to @product
    end

  end

  def destroy
    @review.destroy
    redirect_to @product
  end

  private

  def review_params
    params.require('review').permit(:rating, :description)
  end

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_review
    @review = Review.find(params[:id])
  end

  def valid_action
    unless current_user
      redirect_to :root
    end
  end
end
