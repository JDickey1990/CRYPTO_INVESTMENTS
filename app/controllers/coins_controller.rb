class CoiNsController < ApplicationController

  # GET: /coins
  get "/coins" do
    erb :"/coins/index.html"
  end

  # GET: /coins/new
  get "/coins/new" do
    erb :"/coins/new.html"
  end

  # POST: /coins
  post "/coins" do
    redirect "/coins"
  end

  # GET: /coins/5
  get "/coins/:id" do
    erb :"/coins/show.html"
  end

  # GET: /coins/5/edit
  get "/coins/:id/edit" do
    erb :"/coins/edit.html"
  end

  # PATCH: /coins/5
  patch "/coins/:id" do
    redirect "/coins/:id"
  end

  # DELETE: /coins/5/delete
  delete "/coins/:id/delete" do
    redirect "/coins"
  end
end
