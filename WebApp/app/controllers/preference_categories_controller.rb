class PreferenceCategoriesController < ApplicationController
  before_filter :authorize_user, only: [:new, :create, :show, :index]
  before_action :set_preference_category, only: [:show, :edit, :update, :destroy]


  def index
    user_id = current_user.id
    @preference_categories = Array.new
    @preference_categories = PreferenceCategory.find_by(user_id: user_id)

  end

  def show
  end

  def new
    validation = PreferenceCategory.find_by(user_id: current_user.id)
    if validation != nil
        redirect_to edit_preference_category_path(validation)
      else
      @preference_category = PreferenceCategory.new
    end
  end

  def create
    @preference_category = PreferenceCategory.new(preference_category_params)
    @preference_category.user_id = current_user.id
    respond_to do |format|
      if @preference_category.save
        format.html { redirect_to @preference_category, notice: 'Preference category was successfully created.' }
        format.json { render :show, status: :created, location: @preference_category }
      else
        format.html { render :new }
        format.json { render json: @preference_category.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @preference_category = PreferenceCategory.find(params[:id])
  end

  def update
    respond_to do |format|
      if @preference_category.update(preference_category_params)
        format.html { redirect_to @preference_category, notice: 'Preference category was successfully updated.' }
        format.json { render :show, status: :ok, location: @preference_category }
      else
        format.html { render :edit }
        format.json { render json: @preference_category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @preference_category.destroy
    respond_to do |format|
      format.html { redirect_to preference_sources_url, notice: 'Preference category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def authorize_user
    unless current_user
      redirect_to root_path, alert: "You need to login to continue."
    end
  end

  def set_preference_category
    @preference_category = PreferenceCategory.find(params[:id])
  end

  def preference_category_params
    params.require(:preference_category).permit(:user_id, :category_name => [])
  end
end
