class DinosaursController < ApplicationController
  before_action :set_dinosaur, only: [:show, :update, :destroy, :put_in_cage]

  # GET /dinosaurs
  def index
    query = params[:query].try(:downcase)
    if query.present? && Dinosaur::species[query].present?
      @dinosaurs = Dinosaur.where(species: query)
    else
      @dinosaurs = Dinosaur.all
    end

    render json: @dinosaurs
  end

  # GET /dinosaurs/1
  def show
    render json: @dinosaur
  end

  # POST /dinosaurs
  def create
    dinosaur_params[:species].downcase!
    @dinosaur = Dinosaur.new(dinosaur_params.except(:cage_id))
    @dinosaur.is_carnivore = @dinosaur.carnivore?
    @cage = Cage.find(dinosaur_params[:cage_id])
    @dinosaur = MoveDinosaur.move_to_cage(@dinosaur, @cage)
    @dinosaur.save!
    render json: @dinosaur, status: :created, location: @dinosaur
  rescue => e
    render json: e, status: :unprocessable_entity
  end

  # PATCH/PUT /dinosaurs/1
  def update
    @dinosaur.update!(dinosaur_update_params)
    render json: @dinosaur
  rescue => e
    render json: e, status: :unprocessable_entity
  end

  # DELETE /dinosaurs/1
  def destroy
    @dinosaur.destroy
  end

  def put_in_cage
    @cage = Cage.find(put_in_cage_params[:cage_id])
    @dinosaur = MoveDinosaur.move_to_cage(@dinosaur, @cage)
    @dinosaur.save!
    render json: @dinosaur
  rescue => e
    render json: e, status: :unprocessable_entity
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

    def dinosaur_update_params
      params.fetch(:dinosaur, {}).permit(:name)
    end

    def put_in_cage_params
      params.fetch(:dinosaur, {}).permit(:cage_id)
    end
end
