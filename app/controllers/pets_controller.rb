class PetsController < ApplicationController
  # pour afficher tout les pets du user
  def index
    @pets = current_user.pets
  end

  def new
    @pet = current_user.pets.new
  end

  def create
    @pet = current_user.pets.new pet_param
    if @pet.save
      flash[:success] = 'Animal ajouté'
      redirect_to pets_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update; end

  def destroy; end

  def edit
    @pet = current_user.pets.find(params[:id])
  end

  private

  def pet_param
    params.require(:pet).permit(:name, :birthday, :gender, :species_id)
  end
end
