class BlogsController < ApplicationController
  def index
    @blogs = Blog.all
    @categories = Category.all.map(&:key)
  end
end
