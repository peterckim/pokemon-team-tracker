require 'rack-flash'

class UsersController < ApplicationController
    use Rack::Flash
    
    before '/users*' do
        authenticate_user
    end

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
            session[:user_slug] = @user.slug
            flash[:message] = "Success"
            redirect to "/users/#{session[:user_slug]}"
        else
            flash[:message] = "Incorrect Login Credentials"
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

    post '/users' do # handle signup
        # if username already exists
        if params[:users][:username] == "" || params[:users][:name] == "" || params[:users][:password] == ""
            flash[:message] = "A field is empty."
            redirect to "/users/new"
        else
            if User.find_by(:username => params[:users][:username])
                flash[:message] = "Username Already Exists."
                redirect to "/"
            # if username doesnt already exist, create it
            else
                @user = User.create(params[:users])
                session[:user_id] = @user.id
                session[:user_slug] = @user.slug
                flash[:message] = "Success"
                redirect to "/users/#{@user.slug}"
            end
        end
    end

    # use slugs
    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        @team = Team.where(:user_id => @user.id)

        erb :'user/show'
    end

    get '/users/:slug/edit' do #load edit form
        @user = User.find_by_slug(params[:slug])
        
        erb :'user/edit'
    end

    patch '/users/:slug' do #edit action
        @user = User.find_by_slug(params[:slug])
        @user.update(params[:users])
        @user.save
        
        redirect to "/users/#{@user.slug}"
    end

    delete '/users/:slug/delete' do #delete action
        @user = User.find_by_slug(params[:slug])
        @user.destroy
        session.clear
        
        redirect to "/"
    end
end