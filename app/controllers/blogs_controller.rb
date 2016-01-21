class BlogsController < ApplicationController
  def index
    @blogs = Blog.all
    @categories = Category.all.map(&:key)
  end

  def show
    @blog = Blog.find params[:id]
  end

  def search
    @categories = Category.all.map(&:key)
    @category = Category.find_by_key(params[:blog_type])
    category_id = @category.try(:id)
    @blogs = Blog.search do
      fulltext "#{params[:q]}" if params[:q].present?
      paginate page: params[:page], per_page: 20
      with(:category_id, category_id)  unless category_id.nil?
      with(:status, 1)
    end.results
    Rails.logger.info "======="
    Rails.logger.info @blogs
    Rails.logger.info "======="
    Rails.logger.info @category.to_json
    Rails.logger.info "======="
    render :index
  end
end
