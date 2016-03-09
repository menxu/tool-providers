class Admin::CategoriesController < Admin::ApplicationController
  def index
    @categories = Category.all
  end

  def edit
    @category = Category.find params[:id]
    @categories = Category.all
  end

  def update
    @category = Category.find params[:id]
    if @category.update_attributes(check_params)
      flash[:notice] = '跟新成功'
    else
      flash[:notice] = '跟新失败'
    end
    redirect_to admin_categories_path
  end

  def new
    @category = Category.new
    @categories = Category.all
  end

  def create
    @category = Category.new(check_params)
    if @category.save
      flash[:notice] = '创建成功'
    else
      flash[:notice] = '创建失败'
    end
    redirect_to admin_categories_path
  end

  def destroy
    @category = Category.find params[:id]
    if @category.destroy
      flash[:notice] = '删除成功'
    else
      flash[:notice] = '删除失败'
    end
    redirect_to admin_categories_path
  end

  private
  def check_params
    params[:category].permit(:key, :sdesc, :fdesc, :parent, :icon)
  end
end
