class DinosaursController < ApplicationController
  before_action :set_dinosaur, only: [:show, :update, :destroy, :put_in_cage]

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

  def put_in_cage
    @cage = Cage.find(put_in_cage_params[:cage_id])
    raise 'cage is full' unless @cage.has_space?
    if @cage.is_empty?
      raise 'cage is down' if @cage.down?
      @dinosaur.cage = @cage
      if @dinosaur.is_carnivore?
        @cage.contains_carnivores = true
        @cage.species = @dinosaur.species
      else
        @cage.contains_carnivores = false
      end
      @cage.save!
    else
      if @dinosaur.is_carnivore?
        if @cage.contains_carnivores?
          @cage.species == @dinosaur.species ? @dinosaur.cage = @cage : raise('carnivorous must be of same species')
        else
          raise 'cannot put carnivore in herbivore cage'
        end
      else
        if @cage.contains_carnivores? 
          raise 'cannot put herbivore in carnivore cage'
        else
          @dinosaur.cage = @cage
        end
      end
    end
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

    def put_in_cage_params
      params.fetch(:dinosaur, {}).permit(:cage_id)
    end
end
