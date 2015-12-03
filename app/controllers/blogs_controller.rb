class BlogsController < ApplicationController
  def index
    @categories = Category.all
  end
end
