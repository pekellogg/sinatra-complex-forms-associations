class PetsController < ApplicationController

  # READ
  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  # READ
  get '/pets/new' do
    erb :'/pets/new'
  end

  # CREATE
  post '/pets' do
    @pet = Pet.create(params[:pet])
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  # READ
  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  # READ
  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  # UPDATE
  patch '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(params[:pet])

    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end

    @pet.save
    redirect to "pets/#{@pet.id}"
  end

end