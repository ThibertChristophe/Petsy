class PetsController < ApplicationController
  # pour afficher tout les pets du user
  def index
    @pets = current_user.pets
  end

  def new
    @pet = current_user.pets.new
  end

  def create; end

  def update; end

  def destroy; end

  def edit; end
end
