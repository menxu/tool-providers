module ApplicationHelper
  def active_for(controller_name, navbar_name)
    controller_name.to_sym == navbar_name.to_sym ? 'active' : ""
  end
end
