class CommentsController < ApplicationController
    get '/comments/new' do

        erb :'comment/new'
    end

    post '/comments' do
        @comment = Comment.create(:content => params[:comments][:content])
        @comment.user_id = session[:user_id]
        @comment.pokemon_id = params[:comments][:pokemon_id]
        @comment.save
        
        redirect to "/pokemons/#{@comment.pokemon.slug}"
    end

    get '/teams/:slug' do
        @team = Team.find_by_slug(params[:slug])
        session[:team_slug] = params[:slug]
        session[:team_id] = @team.id
        @pokemon = Pokemon.where(:team_id => session[:team_id])

        erb :'team/show'
    end

    get '/comments/:id/edit' do
        @comment = Comment.find(params[:id])

        erb :'comment/edit'
    end

    patch '/comments/:id' do
        @comment = Comment.find(params[:id])
        @comment.update(params[:comments])
        @comment.save

        redirect to "/pokemons/#{@comment.pokemon.slug}"
    end

    delete '/teams/:slug/delete' do #delete action
        @team = Team.find_by_slug(params[:slug])
        @team.destroy
        
        redirect to "/users/#{session[:user_slug]}"
    end
end