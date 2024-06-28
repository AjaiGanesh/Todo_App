class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]

  # GET /comments or /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1 or /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments or /comments.json
  def create
    @comment = Comment.new(comment_params)
    render json: { data: @comment }, status: :created
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    render json: { data: @comment.update(params) }, status: :ok
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy
    render json: { message: "Deleted successfully" }, status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find_by(id: params[:id])
      raise "Comment not found:status:404" unless @comment.present?
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:description, :task_id)
    end
end
