class ApplicationController < ActionController::Base
    skip_before_action :verify_authenticity_token

    ERROR_CAUSE = {
        ActionController::RoutingError => :not_found,
        ActionController::UnknownFormat => :unprocessable_entity,
        ActionController::ParameterMissing => :unprocessable_entity,
        ActionController::UnpermittedParameters => :unprocessable_entity,
        RuntimeError => :internal_server_error
    }.freeze

    rescue_from 'StandardError' do |e|
        Rails.logger.error e.message
        Rails.logger.error e.backtrace
        error_cause ||= ERROR_CAUSE[e.exception.class] || :internal_server_error
        error_response = { error: e.message }
        render json: error_response, status: error_cause
    end
end
