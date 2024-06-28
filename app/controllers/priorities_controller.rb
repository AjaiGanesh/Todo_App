class PrioritiesController < BaseController
    def index
        priority_query = Priority.all
        render json: {
            count: priority_query.count,
            data: priority_query
        }
    end
end
