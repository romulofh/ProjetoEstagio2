class PreferenceSourcesController < ApplicationController
  before_filter :authorize_user, only: [:new, :show, :edit, :index, :destroy]
  before_action :set_preference_source, only: [:show, :edit, :update, :destroy]
  def index

    @preference_sources = Array.new
    @preference_sources = PreferenceSource.find_by(user_id: current_user.id)
  end

  def show
  end

  def new
    validation = @preference_sources = PreferenceSource.find_by(user_id: current_user.id)
    if validation != nil
      redirect_to edit_preference_source_path(validation)
    else
      @preference_source = PreferenceSource.new
    end
  end

  def create
    @preference_source = PreferenceSource.new(preference_source_params)
    @preference_source.user_id = current_user.id
    respond_to do |format|
      if @preference_source.save

        format.html { redirect_to @preference_source, notice: 'Preference source was successfully created.' }
        format.json { render :show, status: :created, location: @preference_source }
      else
        format.html { render :new }
        format.json { render json: @preference_source.errors, status: :unprocessable_entity }
      end
    end


  end

  def edit
    @preference_source = PreferenceSource.find(params[:id])
  end

  def update
    respond_to do |format|
      if @preference_source.update(preference_source_params)
        format.html { redirect_to @preference_source, notice: 'Preference source was successfully updated.' }
        format.json { render :show, status: :ok, location: @preference_source }
      else
        format.html { render :edit }
        format.json { render json: @preference_source.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @preference_source.destroy
    respond_to do |format|
      format.html { redirect_to preference_sources_url, notice: 'Preference source was successfully destroyed.' }
      format.json { head :no_content }
  end
  end

  private

    def authorize_user
      unless current_user
        redirect_to root_path, alert: "You need to login to continue."
      end
    end

  def set_preference_source
    @preference_source = PreferenceSource.find(params[:id])
  end

  def preference_source_params
    params.require(:preference_source).permit(:user_id ,:source_name => [])
  end
end
