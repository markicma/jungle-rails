class ReviewsController < ApplicationController
  before_action :authorize

  def create
    @review = Product.find(params[:product_id]).reviews.new(description: params[:review][:description], rating: params[:review][:rating])
    @review.user = current_user
    if @review.save
      redirect_to product_path(params[:product_id])
    else
      redirect_to product_path(params[:product_id])
    end
  end

  def destroy
    @review = Review.find params[:id]
    @review.destroy
    redirect_to product_path(params[:product_id])
  end
end
