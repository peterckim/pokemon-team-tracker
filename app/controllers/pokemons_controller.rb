require 'rack-flash'

class PokemonsController < ApplicationController
    use Rack::Flash

    before "/pokemons*" do 
        authenticate_user
    end

    get '/pokemons' do
        @users = User.all

        erb :'pokemon/index'
    end

    get '/pokemons/new' do

        erb :'pokemon/new'
    end

    # Instead of going to pokemon page right away, go back to create pokemon until @team.size is filled.
    post '/pokemons' do
        @pokemon = Pokemon.create(params[:pokemons])
        @pokemon.team_id = session[:team_id]
        @pokemon.assign_image
        @pokemon.save

        if @pokemon.team.size > @pokemon.team.pokemons.length
            flash[:message] = "Created #{@pokemon.name}"
            redirect to "/pokemons/new"
        else
            redirect to "/teams/#{@pokemon.team.slug}"
        end
    end

    get '/pokemons/:slug' do
        @pokemon = Pokemon.find_by_slug(params[:slug])

        erb :'pokemon/show'
    end

    get '/pokemons/:slug/edit' do
        @pokemon = Pokemon.find_by_slug(params[:slug])

        erb :'pokemon/edit'
    end

    patch '/pokemons/:slug' do
        @pokemon = Pokemon.find_by_slug(params[:slug])
        redirect_if_invalid_owner(@pokemon)

        @pokemon.update(params[:pokemons])
        @pokemon.assign_image
        @pokemon.save

        redirect to "/pokemons/#{@pokemon.slug}"
    end

    delete '/pokemons/:slug/delete' do #delete action
        @pokemon = Pokemon.find_by_slug(params[:slug])
        @pokemon.destroy
        

        redirect to "/users/#{session[:user_slug]}"
    end
end