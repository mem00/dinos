class DinosaursController < ApplicationController
  before_action :set_dinosaur, only: [:show, :update, :destroy]

  # GET /dinosaurs
  def index
    @dinosaurs = Dinosaur.all

    render json: @dinosaurs
  end

  # GET /dinosaurs/1
  def show
    render json: @dinosaur
  end

  # POST /dinosaurs
  def create
    dinosaur_params[:species].downcase!
    @dinosaur = Dinosaur.new(dinosaur_params)
    @dinosaur.is_carnivore = @dinosaur.carnivore?
    @dinosaur.save
    render json: @dinosaur, status: :created, location: @dinosaur
  rescue => e
    render json: e, status: :unprocessable_entity
  end

  # PATCH/PUT /dinosaurs/1
  def update
    dinosaur_params[:species].downcase! if dinosaur_params[:species].present?
    @dinosaur.update(dinosaur_params)
    render json: @dinosaur
  rescue => e
    render json: e, status: :unprocessable_entity
  end

  # DELETE /dinosaurs/1
  def destroy
    @dinosaur.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dinosaur
      @dinosaur = Dinosaur.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def dinosaur_params
      params.fetch(:dinosaur, {}).permit(:name, :species, :cage_id)
    end
end
