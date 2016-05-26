class FeedsController < ApplicationController
  before_filter :authorize_admin, only: [:show, :edit, :new, :create]
  before_action :set_feed, only: [:show, :edit, :update, :destroy]

  def index
    @feed = Feed.all
    @preference_categories = PreferenceCategory.all
    @preference_source = PreferenceSource.all
  end

  def new
    @feed = Feed.new
    @sources = Source.all
    @categories = Category.all
  end

  def show
  end

  def create
    @feed = Feed.new(feed_params)

    respond_to do |format|
      if @feed.save
        format.html { redirect_to @feed, notice: 'Feed was successfully created.' }
        format.json { render :show, status: :created, location: @feed }
      else
        format.html { render :new }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit

  end

  def update
    respond_to do |format|
      if @feed.update(feed_params)
        format.html { redirect_to @feed, notice: 'Feed was successfully updated.' }
        format.json { render :show, status: :ok, location: @feed }
      else
        format.html { render :edit }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
      @feed.destroy
      respond_to do |format|
        format.html { redirect_to feeds_url, notice: 'Feed was successfully destroyed.' }
        format.json { head :no_content }
    end
  end



  private

    def authorize_admin
      is_admin?
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_feed
      @feed = Feed.find(params[:id])
    end

  # Never trust parameters from the scary internet, only allow the white list through.
    def feed_params
      params.require(:feed).permit(:source_name, :category_name, :url)
    end
end
