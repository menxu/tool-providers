class BlogsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create]

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

  def new
    @blog = Blog.new
  end

  def create
    blog_params = params[:blog]
    blog_params[:user_id] = current_user.id
    Rails.logger.info blog_params
    @blog = Blog.new(check_params)

    if @blog.save
      render_success('创建成功', {id: @blog.id})
    else
      render_fail('创建失败')
    end
    
  end

  private
  def check_params
    params[:blog].permit!
  end
end
