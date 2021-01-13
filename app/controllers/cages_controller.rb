class CagesController < ApplicationController
  before_action :set_cage, only: [:show, :show_dinosaurs, :update, :destroy, :toggle_power]
  before_action :check_empty, only: [:toggle_power]

  # GET /cages
  def index
    @cages = Cage.all

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

    if @cage.save
      render json: @cage, status: :created, location: @cage
    else
      render json: @cage.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cages/1
  def update
    if @cage.update(cage_params)
      render json: @cage
    else
      render json: @cage.errors, status: :unprocessable_entity
    end
  end

  # DELETE /cages/1
  def destroy
    @cage.destroy
  end

  def toggle_power
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

    def check_empty
      return head 403 unless @cage.dinosaurs_count == 0
    end
    # Only allow a trusted parameter "white list" through.
    def cage_params
      params.fetch(:cage, {}).permit(:power_status, :contains_carnivores, :species)
    end
end
