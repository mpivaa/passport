class AppsController < ApplicationController
  before_action :set_app, only: [:show, :edit, :update, :destroy, :access]

  def dashboard
    @apps = App.all
  end

  # GET /apps
  # GET /apps.json
  def index
    @apps = App.joins(:user_apps).where('user_apps.app_id = apps.id AND user_apps.user_id = ?', current_user.id)
  end

  def access
    uri =  URI.parse(@app.uri)
    new_query_ar = URI.decode_www_form(uri.query) << ["k", AccessKey.gen(current_user)]
    uri.query = URI.encode_www_form(new_query_ar)
    puts uri.to_s, @app.uri
    redirect_to uri.to_s
  end

  # GET /apps/1
  # GET /apps/1.json
  def show
  end

  # GET /apps/new
  def new
    @app = App.new
  end

  # GET /apps/1/edit
  def edit
  end

  # POST /apps
  # POST /apps.json
  def create
    @app = App.new(app_params)

    respond_to do |format|
      if @app.save
        format.html { redirect_to apps_path, notice: 'App foi criado com sucesso.' }
        format.json { render action: 'show', status: :created, location: @app }
      else
        format.html { render action: 'new' }
        format.json { render json: @app.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /apps/1
  # PATCH/PUT /apps/1.json
  def update
    respond_to do |format|
      if @app.update(app_params)
        format.html { redirect_to apps_path, notice: 'App foi atualizado com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @app.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /apps/1
  # DELETE /apps/1.json
  def destroy
    @app.destroy
    respond_to do |format|
      format.html { redirect_to apps_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_app
      @app = App.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def app_params
      params.require(:app).permit(:name, :status, :url, :icon)
    end
end
