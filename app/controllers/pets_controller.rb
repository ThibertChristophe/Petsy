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
      flash[:danger] = 'Error'
      redirect_to new_pet_path
    end
  end

  def update; end

  def destroy; end

  def edit; end

  private

  def pet_param
    params.require(:pet).permit(:name, :birthday, :gender, :species_id)
  end
end
