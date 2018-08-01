require 'rack-flash'

class TeamsController < ApplicationController
    use Rack::Flash

    get '/teams/new' do
        if session[:user_id]

            erb :'team/new'
        else
            redirect to '/'
        end
    end

    post '/teams' do
        if params[:teams][:name] == "" || params[:teams][:size] == ""
            flash[:message] = "A field is empty."
            redirect to '/teams/new'
        else
            @team = Team.create(:name => params[:teams][:name], :size => params[:teams][:size], :user_id => session[:user_id])
            
            redirect to "/teams/#{@team.slug}"
        end
    end

    get '/teams/:slug' do
        if session[:user_id]
            @team = Team.find_by_slug(params[:slug])
            session[:team_slug] = params[:slug]
            session[:team_id] = @team.id
            @pokemon = Pokemon.where(:team_id => session[:team_id])

            erb :'team/show'
        else
            redirect to '/'
        end
    end

    get '/teams/:slug/edit' do
        if session[:user_id]
            @team = Team.find_by_slug(params[:slug])

            erb :'team/edit'
        else
            redirect to '/'
        end
    end

    patch '/teams/:slug' do
        @team = Team.find_by_slug(params[:slug])
        @team.update(params[:teams])
        @team.save

        redirect to "/teams/#{@team.slug}"
    end

    delete '/teams/:slug/delete' do #delete action
        @team = Team.find_by_slug(params[:slug])
        @team.destroy
        
        redirect to "/users/#{session[:user_slug]}"
    end
end