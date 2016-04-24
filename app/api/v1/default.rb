module V1
  module Default
    extend ActiveSupport::Concern

    included do
      prefix "api"
      version "v1", using: :path
      default_format :json
      format :json

      before do
        error!('401 Unauthorized', 401) unless authenticate?
      end

      helpers do
        def logger
          Rails.logger
        end

        def authenticate?
          true
        end
      end

      rescue_from ActiveRecord::RecordNotFound do |e|
        error_response(message: e.message, status: 404)
      end

      rescue_from ActiveRecord::RecordInvalid do |e|
        error_response(message: e.message, status: 422)
      end
    end

  end
end