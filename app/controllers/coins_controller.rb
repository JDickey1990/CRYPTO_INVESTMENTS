class CoiNsController < ApplicationController

  # GET: /coins
  get "/coins" do
    if logged_in? 
      @user = User.find_by_id(session[:user_id])
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
    user = User.find_by_id(session[:user_id])
    @coin =user.coins.create(params)
    e = @coin.amount_invested.to_f
    f = @coin.quantity
   @coin.average_coin_price = e/f
   @coin.save
    redirect "/coins/#{@coin.id}"
  end

  # GET: /coins/5
  get "/coins/:id" do
    # binding.pry
    @coin = Coin.find(params[:id])
    if @coin.user_id.to_i != current_user.id
        # flash[:alert] = "Access Denied"
        redirect "/coins"
    else 
      erb  :"/coins/show.html"
    end 
  end



  # GET: /coins/5/edit
  get "/coins/:id/edit" do
    @coin = Coin.find_by_id(params[:id])
    if @coin.user_id.to_i != current_user.id
      redirect "/coins"
    else 
      #flash error
    end
    erb :"/coins/edit.html"
  end

  # PATCH: /coins/5
  patch "/coins/:id" do
    #  binding.pry
    @coin = Coin.find_by_id(params[:id])
    if params[:name] == "" || params[:symbol] == "" || params[:quantity] == "" || params[:amount_invested] == "" || params[:average_coin_price] == ""  
      redirect "/coins/#{@coin.id}/edit"
    elsif  @coin.user_id.to_i != current_user.id  
      redirect "/coins/#{@coin.id}/edit"
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
    @coin = Coin.find_by_id(params[:id])
    if @coin.user_id.to_i != current_user.id
      redirect "/coins"
    else 
      #flash error
    end
    erb :"/coins/purchased.html"
  end

  # PATCH: /coins/5/purchased
  patch "/coins/:id/purchased" do
    #  binding.pry
    @coin = Coin.find_by_id(params[:id])
    a= @coin.quantity 
    b = params[:quantity].to_d
    @coin.quantity = a+b

    c= @coin.amount_invested
    d= params[:cost].to_f
    @coin.amount_invested = c+d
  
    e = @coin.amount_invested
    f = @coin.quantity
   @coin.average_coin_price = e/f
    @coin.save
    redirect "/coins/#{@coin.id}"
  end

  
  # GET: /coins/:id/sold
  get "/coins/:id/sold" do
    @coin = Coin.find_by_id(params[:id])
    if @coin.user_id.to_i != current_user.id
      redirect '/coins'
    else
      #flash error
    end
    erb :"/coins/sold.html"
  end

   # PATCH: /coins/5/sold
   patch "/coins/:id/sold" do
    #  binding.pry
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

  # DELETE: /coins/5/delete
  delete "/coins/:id/delete" do
    @coin = Coin.find_by_id(params[:id])
    @coin.destroy
    redirect "/coins"
  end



end
