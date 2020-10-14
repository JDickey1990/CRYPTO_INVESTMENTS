class CoiNsController < ApplicationController

  # GET: /coi_ns
  get "/coi_ns" do
    erb :"/coi_ns/index.html"
  end

  # GET: /coi_ns/new
  get "/coi_ns/new" do
    erb :"/coi_ns/new.html"
  end

  # POST: /coi_ns
  post "/coi_ns" do
    redirect "/coi_ns"
  end

  # GET: /coi_ns/5
  get "/coi_ns/:id" do
    erb :"/coi_ns/show.html"
  end

  # GET: /coi_ns/5/edit
  get "/coi_ns/:id/edit" do
    erb :"/coi_ns/edit.html"
  end

  # PATCH: /coi_ns/5
  patch "/coi_ns/:id" do
    redirect "/coi_ns/:id"
  end

  # DELETE: /coi_ns/5/delete
  delete "/coi_ns/:id/delete" do
    redirect "/coi_ns"
  end
end
