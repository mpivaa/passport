class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_apps_options, only: [:edit, :new, :update, :create]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        params[:apps_prompted].each do |app_id|
          UserApp.where(user: @user, app_id: app_id).destroy_all
        end
        params[:apps_confirmed].each do |app_id|
          UserApp.create(user: @user, app_id: app_id)
        end
        format.html { redirect_to users_path, notice: 'Usuário criado com sucesso.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        params[:apps_prompted].each do |app_id|
          UserApp.where(user: @user, app_id: app_id).destroy_all
        end
        params[:apps_confirmed].each do |app_id|
          UserApp.create(user: @user, app_id: app_id)
        end
        format.html { redirect_to users_path, notice: 'Usuário atualizado com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    def set_apps_options
      #not implemented
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      if params[:user][:password].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
      end
      params[:apps_confirmed] = params[:apps_confirmed] || []
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
