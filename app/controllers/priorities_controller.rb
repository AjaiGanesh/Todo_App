class PrioritiesController < ApplicationController
    def index
        priority_query = Priority.all
        render json: {
            count: priority.count,
            data: priority
        }
    end
end
