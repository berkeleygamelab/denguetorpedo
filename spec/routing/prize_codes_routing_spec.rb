require "spec_helper"

describe PrizeCodesController do
  describe "routing" do

    it "routes to #index" do
      get("/prize_codes").should route_to("prize_codes#index")
    end

    it "routes to #new" do
      get("/prize_codes/new").should route_to("prize_codes#new")
    end

    it "routes to #show" do
      get("/prize_codes/1").should route_to("prize_codes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/prize_codes/1/edit").should route_to("prize_codes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/prize_codes").should route_to("prize_codes#create")
    end

    it "routes to #update" do
      put("/prize_codes/1").should route_to("prize_codes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/prize_codes/1").should route_to("prize_codes#destroy", :id => "1")
    end

  end
end
