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

    def forgot_password
        email = params.require(:email)
        user = User.find_by(email: email)
        raise "This email address does not have a user account" unless user.present?
        forgot_password_key = user.generate_password_token
        ####### email part need to do ######
        # subject = "Reset Your User account password"
        # link = "http://localhost:3000/new_password?status=success&key"
        # body = ""
        render json: {message: "Token Generated", data: forgot_password_key}, status: :ok
    end

    def new_password
        password = params.require(:password)
        confirm_password = params.require(:confirm_password)
        raise "Password does not match the confirm password" if password != confirm_password
        user = User.find_by(reset_password_token: params[:secure_key])
        raise "Invalid secure key" unless user.present?
        user.change_password(nil, password, confirm_password)
        render json: { message: "Password successfully changed, please login"}, status: :ok
    end
end