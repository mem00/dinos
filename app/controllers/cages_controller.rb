class CagesController < ApplicationController
  before_action :set_cage, only: [:show, :show_dinosaurs, :update, :destroy, :toggle_power]

  # GET /cages
  def index
    query = params[:query].try(:downcase)
    if query.present? && Cage::power_statuses[query].present?
      @cages = query == "active" ? Cage.active : Cage.down
    else 
      @cages = Cage.all
    end

    render json: @cages
  end

  # GET /cages/1
  def show
    render json: @cage
  end

  def show_dinosaurs
    render json: @cage.dinosaurs
  end

  # POST /cages
  def create
    @cage = Cage.new(cage_params)
    @cage.save!
    render json: @cage, status: :created, location: @cage
  rescue => e
    render json: e, status: :unprocessable_entity
  end

  # PATCH/PUT /cages/1
  def update
    @cage.update!(cage_params)
    render json: @cage
  rescue => e
    render json: e, status: :unprocessable_entity
  end

  # DELETE /cages/1
  def destroy
    @cage.destroy
  end

  def toggle_power
    raise "can't power off, not empty" unless @cage.is_empty?
    @cage.down? ? @cage.active! : @cage.down!
    render json: @cage
  rescue => e
    render json: e, status: :unprocessable_entity
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cage
      @cage = Cage.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def cage_params
      params.fetch(:cage, {}).permit(:power_status, :contains_carnivores, :species)
    end
end
