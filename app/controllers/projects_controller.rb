class ProjectsController < BaseController
  before_action :set_project, only: %i[ show edit update destroy ]

  # GET /projects or /projects.json
  def index
    project_query = Project.where(status: 1)                                                
    render json: {
      count: project_query.count,
      data: project_query,
    }
  end

  # GET /projects/1 or /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects or /projects.json
  def create
    @project = Project.new(project_params)
    @project.create_project(@current_user)
    render json: { data: @project, message: "Project Created Successfully"}, status: :created
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    @project.move_or_update_project(params)
    render json: { data: @project, message: "Project Updated Successfully"}
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    @project.destroy
    render json: { message: "Deleted Successfully"}, status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find_by(id: params[:id])
      raise "No project found:status:404" unless @project.present?
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:description, :parent_id)
    end
end
