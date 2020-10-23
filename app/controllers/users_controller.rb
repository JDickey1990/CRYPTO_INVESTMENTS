class UseRsController < ApplicationController
 
  # GET: /login
  get "/login" do
    if logged_in?
      flash[:error] = "You are currently logged in."
      redirect to '/coins' 
    else
      erb :"/users/login.html"
    end
  end

  post '/login' do 
    if params[:username] == "" || params[:password] == "" 
      flash[:error] = "Please fill out the username and password fields."
      redirect "/login"
    else 
         user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect "/coins"
        else
          flash[:error] = "Incorrect Username or Password."
            redirect "/login"
        end
    end
  end

  # GET: /users/new
  get "/signup" do
    if logged_in?
      flash[:error] = "You are currently logged in."
      redirect to '/coins' 
    else
      erb :"/users/signup.html"
    end
  end

  # POST: /users
  post "/signup" do
    if params[:username] == "" || params[:password] == "" 
      flash[:error] = "Please fill out the username and password fields."
      redirect "/signup"
    else
        user = User.new(:username => params[:username], :password => params[:password])	
        if user.save
            session[:user_id] = user.id
            redirect "/coins"
        else
          flash[:error] = "Username is in use or Password is invalid."
          redirect "/signup"
        end
      end
  end

  get '/logout' do 
    session.destroy
    erb :'logout.html'
  end

  # GET: /users/5
  get "/users/:id" do
    @coins = current_user.coins.all

    erb :"/users/show.html"
  end

  # GET: /users/5/edit
  get "/users/:id/edit" do
    erb :"/users/edit.html"
  end

  # PATCH: /users/5
  patch "/users/:id" do
      #  binding.pry
    if params[:username] == "" || params[:password]== "" 
      flash[:error] = "Please fill out the username and password fields."
      redirect "/users/#{current_user.id}/edit"
    elsif current_user.authenticate(params[:password])
        current_user.update(username: params[:username], password: params[:password])
        redirect "/users/#{current_user.id}"
    else
      flash[:error] = "Please fill out the correct password."
      redirect "/users/#{current_user.id}/edit"
    end
  end
  
  # DELETE: /users/5/delete
  delete "/users/:id/delete" do
    user = User.find_by_id(params[:id])
    session.clear
    user.destroy
      redirect "/"
  end
end


