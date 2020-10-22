class CoiNsController < ApplicationController

  # GET: /coins
  get "/coins" do
    if logged_in? 
      @coins = current_user.coins.all
      erb :"/coins/index.html"
    else
      flash[:error] = "You must be logged in to access this page."
      erb :'/users/login.html'
    end
  end

  # GET: /coins/new
  get "/coins/new" do
    erb :"/coins/new.html"
  end

  # POST: /coins
  post "/coins" do
    if params[:name] == "" || params[:symbol] == "" || params[:quantity] == "" || params[:amount_invested] == "" || params[:average_coin_price] == "" 
      flash[:error] = "Please fill out all of the available fields" 
      redirect "/coins/new"
    elsif params[:amount_invested].include?(",")
      flash[:error] = "Please do not include any commas" 
      redirect "/coins/new"
    else  
      @coin = current_user.coins.create(params)
      e = @coin.amount_invested.to_f
      f = @coin.quantity
      @coin.average_coin_price = e/f
      @coin.save
    end
    redirect "/coins/#{@coin.id}"
  end

  # GET: /coins/5
  get "/coins/:id" do
    if coin.user_id.to_i != current_user.id
        flash[:error] = "Access Denied"
        redirect "/coins"
    else 
      erb  :"/coins/show.html"
    end 
  end

  # GET: /coins/5/edit
  get "/coins/:id/edit" do
    if coin.user_id.to_i != current_user.id
      flash[:error] = "Access Denied"
      redirect "/coins"
    else 
      erb :"/coins/edit.html"
    end
  end

  # PATCH: /coins/5
  patch "/coins/:id" do
    if params[:name] == "" || params[:symbol] == "" || params[:quantity] == "" || params[:amount_invested] == "" || params[:average_coin_price] == "" 
      flash[:error] = "Please fill out all of the available fields" 
      redirect "/coins/#{coin.id}/edit"
    elsif params[:amount_invested].include?(",")
      flash[:error] = "Please do not include any commas" 
      redirect "/coins/new"
    elsif  coin.user_id.to_i != current_user.id  
      flash[:error] = "Access Denied"
      redirect "/coins/#{coin.id}/edit"
    else  
      @coin.name = params[:name] 
      @coin.symbol = params[:symbol]
      @coin.quantity = params[:quantity]
      @coin.amount_invested = params[:amount_invested]
      @coin.average_coin_price = params[:average_coin_price]
      @coin.save
      redirect "/coins/#{@coin.id}"
    end
  end

  # GET: /coins/:id/purchased
  get "/coins/:id/purchased" do
    if coin.user_id.to_i != current_user.id
      flash[:error] = "Access Denied"
      redirect "/coins"
    else 
      erb :"/coins/purchased.html"
    end
  end

  # PATCH: /coins/5/purchased
  patch "/coins/:id/purchased" do
    if params[:quantity] == "" || params[:amount_invested] == ""
      flash[:error] = "Please fill out all of the available fields" 
      redirect "/coins/#{coin.id}/purchased"
    elsif params[:cost].include?(",")
      flash[:error] = "Please do not include any commas" 
      redirect "/coins/#{coin.id}/purchased"
    else
      @coin = Coin.find_by_id(params[:id])
      a= @coin.quantity 
      b = params[:quantity].to_d
      @coin.quantity = a+b

      c= @coin.amount_invested
      d= params[:cost].to_d
      @coin.amount_invested = c+d
    
      e = @coin.amount_invested
      f = @coin.quantity
      @coin.average_coin_price = e/f
      @coin.save
      redirect "/coins/#{@coin.id}"
    end
  end

  
  # GET: /coins/:id/sold
  get "/coins/:id/sold" do
    @coin = Coin.find_by_id(params[:id])
    if @coin.user_id.to_i != current_user.id
      flash[:error] = "Access Denied"
      redirect '/coins'
    else
      erb :"/coins/sold.html"
    end
  end

   # PATCH: /coins/5/sold
   patch "/coins/:id/sold" do
    if params[:quantity] == "" || params[:amount_invested] == ""
      flash[:error] = "Please fill out all of the available fields" 
      redirect "/coins/#{coin.id}/sold"
    elsif params[:cost].include?(",")
      flash[:error] = "Please do not include any commas" 
      redirect "/coins/#{coin.id}/sold"
    else
      @coin = Coin.find_by_id(params[:id])
      a= @coin.quantity 
      b = params[:quantity].to_d
      @coin.quantity = a-b

      c= @coin.amount_invested
      d= params[:cost].to_i
      @coin.amount_invested = c-d
    
      e = @coin.amount_invested
      f = @coin.quantity
      @coin.average_coin_price = e/f
      @coin.save
      redirect "/coins/#{@coin.id}"
    end
  end

  # DELETE: /coins/5/delete
  delete "/coins/:id/delete" do
    @coin = Coin.find_by_id(params[:id])
    @coin.destroy
    redirect "/coins"
  end



end
