class TasksController < BaseController
  before_action :set_task, only: %i[ show edit update destroy ]

  # GET /tasks or /tasks.json
  def index
    @tasks = Task.all
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)
    @task.create_task
    render json: { data: @task }, status: :created
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    @project.move_or_update_task(params)
        
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy
    render json: { message: "Deleted Successfully"}, status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find_by(id: params[:id])
      raise "Task not found:status:404" unless @task
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:project_id, :description, :status_id, :priority_id, :label, :start_date_at, :due_date_at, :parent_id)
    end
end
