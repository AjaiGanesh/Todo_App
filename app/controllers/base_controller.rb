class BaseController < ApiController
    prepend_before_action :check_active_session

    def check_active_session
        raise "Missing header Authorization:status:404" unless request.headers["Authorization"]
        @current_user_session = Session.find_by(auth_token: request.headers["Authorization"])
        raise "No active Session found" unless @current_user_session
        payload = nil
        begin
            payload = @current_user_session.decode_token
        rescue JWT::VerificationError => e
            raise 'Token Verification Error:status:403'
        end
        raise "Unable to decode token:status:500" unless payload
        raise "Token mismatch:status:403" unless payload[:session_key] == @current_user_session.session_key
        raise "Token expired:status:403" if @current_user_session.expired?
        @current_user = @current_user_session.user
        raise "No current user found:status:404" unless @current_user
    end

    def logout
        @current_user_session.logout
        render json: {message: "logged out successfully "}, status: :ok
    end
end