class Admin::SitesController < Admin::ApplicationController
  def index
    @sites = Site.all
  end

  def new
    @site = Site.new
  end

  def create
    @site = Site.new(check_params)
    if @site.save
      flash[:notice] = '创建成功'
    else
      flash[:notice] = '创建失败'
    end
    redirect_to :back
  end

  def edit
    @site = Site.find params[:id]
  end

  def update
    @site = Site.find params[:id]
    if @site.update_attributes(check_params)
      flash[:notice] = '修改成功'
    else
      flash[:notice] = '修改失败'
    end
    redirect_to :back    
  end

  def destroy
    @site = Site.find params[:id]
    if @site.destroy
      flash[:notice] = '删除成功'
    else
      flash[:notice] = '删除失败'
    end
    redirect_to :back   
  end

  private
  def check_params
    params[:site].permit!
  end
end
