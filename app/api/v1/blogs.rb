module V1
  class Blogs < Base
    resource :blogs do
      desc "根据页数来获取blogs"
      params do
        requires :page, type: String, regexp: /[\d]/, desc: "page integer"
      end

      get '/' do
        page = params[:page].to_i
        {blogs: Blog.limit(10).offset(10*page).collect(&:api_json)}
      end

      desc "get blog by id"
      params do
        requires :id, type: Integer, regexp: /^[0-9]+$/, desc: "id integer"
      end

      get ':id' do
        Blog.find(params[:id]).try(:api_json)
      end
    end
  end
end