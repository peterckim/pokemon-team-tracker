class PokemonsController < ApplicationController
    get '/pokemons/new' do
        erb :'pokemon/new'
    end

    post '/pokemons' do
        @pokemon = Pokemon.create(params[:pokemons])
        @pokemon.team_id = session[:team_id]
        @pokemon.assign_image
        @pokemon.save

        redirect to "/pokemons/#{@pokemon.slug}"
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
        @pokemon.update(params[:pokemons])
        @pokemon.assign_image
        @pokemon.save

        redirect to "/pokemons/#{@pokemon.slug}"
    end

    delete '/pokemons/:slug/delete' do #delete action
        @pokemon = Pokemon.find_by_slug(params[:slug])
        @pokemon.destroy
        
        redirect to "/teams/#{session[:team_slug]}"
    end
end