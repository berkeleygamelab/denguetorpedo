require "spec_helper"

describe PrizesController do
  describe "routing" do
    before(:each) do
      @prize = FactoryGirl.create(:prize)
    end

    it "routes to #index" do
      get("/premios").should route_to("prizes#index")
    end

    it "routes to #new" do
      get("/premios/new").should route_to("prizes#new")
    end

    it "routes to #show" do
      get("/premios/1").should route_to("prizes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/premios/1/edit").should route_to("prizes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/premios").should route_to("prizes#create")
    end

    it "routes to #update" do
      put("/premios/1").should route_to("prizes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/premios/1").should route_to("prizes#destroy", :id => "1")
    end

  end
end
