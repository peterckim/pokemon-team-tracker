class TeamsController < ApplicationController
    get '/teams/new' do

        erb :'team/new'
    end

    post '/teams' do
        @team = Team.create(:name => params[:teams][:name], :size => params[:teams][:size], :user_id => session[:user_id])
        
        redirect to "/teams/#{@team.slug}"
    end

    get '/teams/:slug' do
        @team = Team.find_by_slug(params[:slug])
        session[:team_slug] = params[:slug]
        session[:team_id] = @team.id
        @pokemon = Pokemon.where(:team_id => session[:team_id])

        erb :'team/show'
    end

    delete '/teams/:slug/delete' do #delete action
        @team = Team.find_by_slug(params[:slug])
        @team.destroy
        
        redirect to "/users/#{session[:user_slug]}"
    end
end