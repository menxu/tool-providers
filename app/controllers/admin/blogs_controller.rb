class Admin::BlogsController < Admin::ApplicationController

  def index
    @blogs = Blog.all
  end

  def show
    @blog = Blog.find params[:id]
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(check_params)
    if @blog.save
      flash[:notice] = '创建成功'
    else
      flash[:notice] = '创建失败'
    end
    redirect_to admin_blogs_path
  end

  def edit
    @blog = Blog.find params[:id]
  end

  def update
    @blog = Blog.find params[:id]
    if @blog.update_attributes(check_params)
      flash[:notice] = '修改成功'
    else
      flash[:notice] = '修改失败'
    end
    redirect_to admin_blogs_path    
  end

  def destroy
    @blog = Blog.find params[:id]
    if @blog.destroy
      flash[:notice] = '删除成功'
    else
      flash[:notice] = '删除失败'
    end
    redirect_to admin_blogs_path           
  end

  private
  def check_params
    params[:blog].permit!
  end
end
