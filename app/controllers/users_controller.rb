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
            redirect to "/users/failure"
        end
    end

    get '/users/failure' do
        erb :'user/failure'
    end

    get '/users/new' do

        erb :'user/new'
    end

    post '/users' do
        @user = User.create(:username => params[:users][:username], :name => params[:users][:name], :password => params[:users][:password])
        
        redirect to "/users/#{@user.id}"
    end

    get '/users/:id' do
        @user = User.find(params[:id])

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
end