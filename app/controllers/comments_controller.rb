class CommentsController < ApplicationController

    before '/comments*' do
        authenticate_user
    end

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
end