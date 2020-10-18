class UseRsController < ApplicationController

  # GET: /login
  get "/login" do
    if logged_in?
      redirect to '/coins' 
    else
      erb :"/users/login.html"
    end
  end

  post '/login' do 
    #  binding.pry
    if params[:username] == "" || params[:password] == "" 
        redirect "/login"
    else 
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect "/coins"
        else
            redirect "/login"
        end
    end
  end

  # GET: /users/new
  get "/signup" do
    if logged_in?
        redirect to '/coins' 
    else
      erb :"/users/signup.html"
    end
  end

  # POST: /users
  post "/signup" do
      u = User.find_by(username: params[:username])
    if u != nil || params[:username] == "" || params[:password] == "" 
        redirect "/signup"
    else
        user = User.new(:username => params[:username], :password => params[:password])	
        if user.save
            session[:user_id] = user.id
            redirect "/coins"
        else
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
    @user = User.find_by_id(params[:id])
    @coins = @user.coins.all

    erb :"/users/show.html"
  end

  # GET: /users/5/edit
  get "/users/:id/edit" do
    @user = User.find_by_id(params[:id])
    erb :"/users/edit.html"
  end

  # PATCH: /users/5
  patch "/users/:id" do
    @user = User.find_by_id(params[:id])
    if params[:username] == "" 
      redirect "/users/#{@user.id}"
    else
      @user.username = params[:username]
      @user.save
      redirect "/users/#{@user.id}"
    end
  end
  

  # DELETE: /users/5/delete
  delete "/users/:id/delete" do
    user = User.find_by_id(params[:id])
    session.clear
    user.destroy
      redirect "/login"
  end
end


