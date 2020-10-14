class UseRsController < ApplicationController

  # GET: /use_rs
  get "/use_rs" do
    erb :"/use_rs/index.html"
  end

  # GET: /use_rs/new
  get "/use_rs/new" do
    erb :"/use_rs/new.html"
  end

  # POST: /use_rs
  post "/use_rs" do
    redirect "/use_rs"
  end

  # GET: /use_rs/5
  get "/use_rs/:id" do
    erb :"/use_rs/show.html"
  end

  # GET: /use_rs/5/edit
  get "/use_rs/:id/edit" do
    erb :"/use_rs/edit.html"
  end

  # PATCH: /use_rs/5
  patch "/use_rs/:id" do
    redirect "/use_rs/:id"
  end

  # DELETE: /use_rs/5/delete
  delete "/use_rs/:id/delete" do
    redirect "/use_rs"
  end
end
