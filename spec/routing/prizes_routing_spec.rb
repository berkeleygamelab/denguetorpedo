require "spec_helper"

describe PrizesController do
  describe "routing" do

    it "routes to #index" do
      get("/prizes").should route_to("prizes#index")
    end

    it "routes to #new" do
      get("/prizes/new").should route_to("prizes#new")
    end

    it "routes to #show" do
      get("/prizes/1").should route_to("prizes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/prizes/1/edit").should route_to("prizes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/prizes").should route_to("prizes#create")
    end

    it "routes to #update" do
      put("/prizes/1").should route_to("prizes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/prizes/1").should route_to("prizes#destroy", :id => "1")
    end

  end
end
