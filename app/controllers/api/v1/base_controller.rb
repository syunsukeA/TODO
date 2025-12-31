module Api
  module V1
    class BaseController < ActionController::API
      rescue_from StandardError, with: :render_internal_server_error

      private

      def render_internal_server_error
        render json: { error: "internal_server_error" }, status: :internal_server_error
      end
    end
  end
end
