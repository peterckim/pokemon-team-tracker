class UsersController < ApplicationController
    get '/users' do
        @user = User.all

        erb :'user/index'
    end

    get '/users/login' do # load login form
        erb :'user/login'
    end

    post '/users/login' do # login action
        @user = User.find_by(:username => params[:users][:username])
        if @user && @user.authenticate(params[:users][:password])
            session[:user_id] = @user.id
            redirect to "/users/#{session[:user_id]}"
        else
            redirect to "/"
        end
    end

    get '/users/logout' do #logout action
        session.clear

        redirect to "/"
    end

    get '/users/new' do
        erb :'user/new'
    end

    post '/users' do
        if User.find_by(:username => params[:users][:username])
            redirect to "/"
        else
            @user = User.create(params[:users])
            redirect to "/users/#{@user.id}"
        end
    end

    get '/users/:id' do
        @user = User.find(params[:id])
        @team = Team.where(:user_id => params[:id])

        erb :'user/show'
    end

    get '/users/:id/edit' do #load edit form
        @user = User.find(params[:id])
        erb :'user/edit'
    end

    patch '/users/:id' do #edit action
        @user = User.find(params[:id])
        @user.username = params[:users][:username]
        @user.name = params[:users][:name]
        @user.password = params[:users][:password]
        @user.save

        redirect to "/users/#{user.id}"
    end

    delete '/users/:id/delete' do #delete action
        @user = User.find(params[:id])
        @user.delete
        session.clear
        
        redirect to "/"
    end
end