class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :user_params, only: %i[ create ]
  # rescue_from StandardError, with: :render_error_response 
  
  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    ActiveRecord::Base.transaction do
      @user = User.new
      @user.create_user(user_params)
      render json: @user.errors, status: :unprocessable_entity unless @user.valid?
      render json: {data: @user.as_json(:except => [:password_digest, :deleted_at, :last_login_at, :last_logout_at, :num_of_logins, :num_of_logouts, :reset_password_token, :reset_password_requested_at]), message: "User created and please sign in"}, status: :created
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :first_name, :last_name, :password)
    end
end
