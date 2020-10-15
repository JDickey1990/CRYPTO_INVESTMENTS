require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'

    enable :sessions
    set :session_secret, "password security"
  end


  get "/" do
    erb :welcome
  end

  helpers do
    def current_user
       User.find(session[:user_id])
    end

    def logged_in?
        !!session[:user_id]
    end
  end  

  get '/signup' do 
    if logged_in?
        redirect to '/coins' 
    else
        erb :'signup.html'
    end
end

post '/signup' do 
    if params[:username] == "" || params[:password] == ""
        redirect "/signup"
    else
        user =User.new(:username => params[:username], :password => params[:password])	
        if user.save
            session[:user_id] = user.id
            redirect "/coins"
        else
            redirect "/signup"
        end
    
    end
end

  get '/login' do 
    if logged_in?
        redirect to '/coins' 
    else
        erb :'login.html'
    end
  end

  post '/login' do 
    
  end

  get '/logout' do 
    session.clear
    erb :'logout.html'
  end

end
