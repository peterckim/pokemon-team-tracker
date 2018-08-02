require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
    use Rack::Flash
    
    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, ENV.fetch('SESSION_SECRET')
    end

    get '/' do
        if logged_in?
            redirect to "/users/#{session[:user_slug]}"
        else
            erb :index
        end
    end

    helpers do
        def current_user
            @current_user ||= User.find_by(:id => session[:user_id])
        end

        def logged_in?
            !!session[:user_id]
        end

        def valid_owner?(obj)
            logged_in? && session[:user_id] == obj.user_id
        end

        def redirect_if_invalid_owner(obj)
            unless valid_owner?(obj)
                flash[:message] = "Can only edit your own!"
                redirect to '/'
            end

        end

        def authenticate_user
            unless current_user
                flash[:message] = "Must be logged in to view this page!"
                redirect to '/'
            end
        end
    end
end