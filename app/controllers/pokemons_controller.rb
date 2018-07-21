class PokemonsController < ApplicationController
    get '/pokemons/new' do
        erb :'pokemon/new'
    end

    post '/pokemons' do
        # Currently returning an error!
        @pokemon = Pokemon.create(:name => params[:pokemons][:name], :type => params[:pokemons][:type], :gender => params[:pokemons][:gender], :nature => params[:pokemons][:nature], :health => params[:pokemons][:health], :attack => params[:pokemons][:attack], :defense => params[:pokemons][:defense], :special_attack => params[:pokemons][:special_attack], :special_defense => params[:pokemons][:special_defense])

        redirect to "/pokemons/#{@pokemon.id}"
    end

    get '/pokemons/:id' do
        @pokemon = Pokemon.find(params[:id])

        erb :'pokemon/show'
    end
end