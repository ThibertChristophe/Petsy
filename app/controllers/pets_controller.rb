class PetsController < ApplicationController
  before_action :set_pet, only: %i[edit update destroy show]

  # pour afficher tout les pets du user
  def index
    @pets = current_user.pets
  end

  def new
    @pet = current_user.pets.new
  end

  def create
    if @pet.save
      flash[:success] = 'Animal ajouté'
      redirect_to pets_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @pet.update pet_params
      flash[:success] = 'Animal modifié'
      redirect_to pets_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @pet.destroy
    redirect_to pets_path
  end

  def show; end
  def edit; end

  private

  def set_pet
    @pet = current_user.pets.find(params[:id])
  end

  def pet_params
    params.require(:pet).permit(:name, :birthday, :gender, :species_id)
  end
end
