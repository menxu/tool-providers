class CategoriesController < ApplicationController

  def index    
  end

  def trend
    @how_much = case params[:how_much]
    when "most_a_week"
      :most_a_week
    when "most_a_month"
      :most_a_month
    else
      :most_a_week
    end

    count = 20

    @cond = :by_times
    case params[:cond]
    when "by_investments"
    #   @investments_most = Investment.send(@how_much, count)
    #   :by_investments
    # when "by_stars"
    #   @stars_most = Star.send(@how_much, count)
    #   :by_stars
    # when "by_times"
    #   @projects_most = Project.send(@how_much, count)
      :by_times
    # when "by_talks"
    #   @talks_most = Talk.send(@how_much, count)
    #   :by_talks
    # else
    #   @investments_most = Investment.most_a_week
    #   :by_investments
    end

  end

  def all
    
  end
end
