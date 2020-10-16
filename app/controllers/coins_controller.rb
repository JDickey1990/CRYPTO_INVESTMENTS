class CoiNsController < ApplicationController

  # GET: /coins
  get "/coins" do
    if logged_in?
      @user = User.find_by(session[:user_id])
      @coins = @user.coins.all
      erb :"/coins/index.html"
    else
      erb :'login.html'
    end
  end

  # GET: /coins/new
  get "/coins/new" do
    erb :"/coins/new.html"
  end

  # POST: /coins
  post "/coins" do
    # binding.pry
    user = User.find_by(session[:user_id])
    @coin =user.coins.create(params)
    redirect "/coins/#{@coin.id}"
  end

  # GET: /coins/5
  get "/coins/:id" do
    @coin = Coin.find_by_id(params[:id])
    erb :"/coins/show.html"
  end

  # GET: /coins/5/edit
  get "/coins/:id/edit" do
    @coin = Coin.find_by_id(params[:id])
    erb :"/coins/edit.html"
  end

  # PATCH: /coins/5
  patch "/coins/:id" do
    redirect "/coins/:id"
  end

  # DELETE: /coins/5/delete
  delete "/coins/:id/delete" do
    @coin = Coin.find_by_id(params[:id])
    @coin.destroy
    redirect "/coins"
  end



end
