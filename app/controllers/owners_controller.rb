class OwnersController < ApplicationController
  # READ
  get '/owners' do
    @owners = Owner.all
    erb :'/owners/index' 
  end

  # READ
  get '/owners/new' do 
    @pets = Pet.all
    erb :'/owners/new'
  end

  # CREATE
  post '/owners' do 
    @owner = Owner.create(params[:owner])
    if !params["pet"]["name"].empty?
      # ActiveRecord treats shovel operator like UPDATE
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end
    redirect "/owners/#{@owner.id}"
  end

  # READ
  get '/owners/:id/edit' do 
    @owner = Owner.find(params[:id])
    @pets = Pet.all
    erb :'/owners/edit'
  end

  # READ
  get '/owners/:id' do 
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end

  # UPDATE
  patch '/owners/:id' do 
    @owner = Owner.find(params[:id])
    @owner.update(params["owner"])

    # lesson contains but solution does not
    # if !params[:owner].keys.include?("pet_ids")
    #   params[:owner]["pet_ids"] = []
    # end
  
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end
    redirect "owners/#{@owner.id}"
  end

end