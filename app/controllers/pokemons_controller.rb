class PokemonsController < ApplicationController
    get '/pokemons/new' do
        erb :'pokemon/new'
    end

    post '/pokemons' do
        # Currently returning an error!
        @pokemon = Pokemon.create(:name => params[:pokemons][:name], :element => params[:pokemons][:element], :gender => params[:pokemons][:gender], :nature => params[:pokemons][:nature], :health => params[:pokemons][:health], :attack => params[:pokemons][:attack], :defense => params[:pokemons][:defense], :special_attack => params[:pokemons][:special_attack], :special_defense => params[:pokemons][:special_defense], :speed => params[:pokemons][:speed], :team_id => session[:team_id])

        redirect to "/pokemons/#{@pokemon.id}"
    end

    get '/pokemons/:id' do
        @pokemon = Pokemon.find(params[:id])

        erb :'pokemon/show'
    end

    delete '/pokemons/:id/delete' do #delete action
        @pokemon = Pokemon.find(params[:id])
        @pokemon.delete
        
        redirect to "/teams/#{session[:team_id]}"
    end
end