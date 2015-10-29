class Admin::DashboardController < Admin::ApplicationController
  def index
    @users_count = User.count
    @tool_count = 100
    @tool_requires_count = 120
    @tool_requires_success_count = 50
    @tool_reads_count = 2000
  end
end
