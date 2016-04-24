module V1
  class Base < Grape::API
    include V1::Default

    mount V1::Blogs
  end
end