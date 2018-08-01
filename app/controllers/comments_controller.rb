class CommentsController < ApplicationController
    get '/comments/new' do
        if session[:user_id]

            erb :'comment/new'
        else
            redirect to '/'
        end
    end

    post '/comments' do
        @comment = Comment.create(:content => params[:comments][:content])
        @comment.user_id = session[:user_id]
        @comment.pokemon_id = params[:comments][:pokemon_id]
        @comment.save
        
        redirect to "/pokemons/#{@comment.pokemon.slug}"
    end

    get '/comments/:id/edit' do
        if session[:user_id]
            @comment = Comment.find(params[:id])

            erb :'comment/edit'
        else
            redirect to '/'
        end
    end

    patch '/comments/:id' do
        @comment = Comment.find(params[:id])
        @comment.update(params[:comments])
        @comment.save

        redirect to "/pokemons/#{@comment.pokemon.slug}"
    end
end