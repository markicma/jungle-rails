class Admin::CategoriesController < ApplicationController

  http_basic_authenticate_with name: ENV['AUTH_USERNAME'], password: ENV['AUTH_PASSWORD']

  def index
    @categories = Category.order(id: :desc).all
  end

  def new
    @category = Category.new
  end
end
