require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    
    use Rack::Flash, :sweep => true
    enable :sessions
    set :session_secret, "password security"
  end


  get "/" do
    erb :welcome
  end

  helpers do
    def current_user
       @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def logged_in?
        !!current_user
    end

    def coin
      @coin = Coin.find_by_id(params[:id])
    end

    def flash_types
      [:success, :notice, :warning, :error]
    end
  end  

 end
