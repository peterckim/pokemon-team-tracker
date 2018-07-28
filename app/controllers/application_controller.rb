require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
    use Rack::Flash
    
    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, "secret"
        # set :session_secret, "ENV.fetch('SESSION_SECRET')"
    end

    get '/' do
        erb :index
    end
end