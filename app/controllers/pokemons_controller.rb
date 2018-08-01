require 'rack-flash'

class PokemonsController < ApplicationController
    use Rack::Flash

    get '/pokemons' do
        if session[:user_id]
            @users = User.all

            erb :'pokemon/index'
        else
            redirect to '/'
        end
    end

    get '/pokemons/new' do
        if session[:user_id]

            erb :'pokemon/new'
        else
            redirect to '/'
        end
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
        if session[:user_id]
            @pokemon = Pokemon.find_by_slug(params[:slug])

            erb :'pokemon/show'
        else
            redirect to '/'
        end
    end

    get '/pokemons/:slug/edit' do
        if session[:user_id]
            @pokemon = Pokemon.find_by_slug(params[:slug])

            erb :'pokemon/edit'
        else
            redirect to '/'
        end
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
        

        redirect to "/users/#{session[:user_slug]}"
    end
end