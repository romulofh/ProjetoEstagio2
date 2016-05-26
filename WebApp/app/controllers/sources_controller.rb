class SourcesController < ApplicationController
  before_filter :authorize_admin, only: [:show, :edit, :new, :create]
  before_action :set_source, only: [:show, :edit, :update, :destroy]
  def index
    @sources = Source.all
  end

  def new
    @source = Source.new
  end

  def show

  end

  def create
    @source = Source.new(source_params)

    respond_to do |format|
      if @source.save
        format.html { redirect_to @source, notice: 'source was successfully created.' }
        format.json { render :show, status: :created, location: @source }
      else
        format.html { render :new }
        format.json { render json: @source.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @source = Source.find(params[:id])
  end

  def update
    respond_to do |format|
      if @source.update(source_params)
        format.html { redirect_to @source, notice: 'source was successfully updated.' }
        format.json { render :show, status: :ok, location: @source }
      else
        format.html { render :edit }
        format.json { render json: @source.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
      @source.destroy
      respond_to do |format|
        format.html { redirect_to sources_url, notice: 'source was successfully destroyed.' }
        format.json { head :no_content }
    end
  end

  private

    def authorize_admin
      is_admin?
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_source
      @source = Source.find(params[:id])
    end

  # Never trust parameters from the scary internet, only allow the white list through.
    def source_params
      params.require(:source).permit(:name)
    end
end
