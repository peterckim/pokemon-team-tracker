class TeamsController < ApplicationController
    get '/teams/new' do

        erb :'team/new'
    end

    post '/teams' do
        @team = Team.create(:name => params[:teams][:name], :size => params[:teams][:size])

        redirect to "/teams/#{@team.id}"
    end

    get '/teams/:id' do
        @team = Team.find(params[:id])

        erb :'team/show'
    end
end