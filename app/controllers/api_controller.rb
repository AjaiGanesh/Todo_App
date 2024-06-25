class ApiController < ApplicationController
    rescue_from StandardError, with: :render_error_response

    def render_error_response(error)
        Rails.logger.info "render_error_response called"
        e = error.message.split(':status:')
        Rails.logger.error "Returning HTTP code = '#{e[1]}'"
        Rails.logger.error e[0]
        Rails.logger.error error.backtrace
        render json: { "error": e[0] }, status: e[1] || 500
    end

    def login
        user_email = params.require(:email)
        user = User.find_by(email: user_email)
        raise "User not found:status:404" unless user.present?
        password = params.require(:password)
        token = user.login(password)
        render json: { auth_token: token }, status: :ok
    end
end