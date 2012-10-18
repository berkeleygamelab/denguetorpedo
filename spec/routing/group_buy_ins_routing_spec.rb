require "spec_helper"

describe GroupBuyInsController do
  describe "routing" do

    it "routes to #index" do
      get("/group_buy_ins").should route_to("group_buy_ins#index")
    end

    it "routes to #new" do
      get("/group_buy_ins/new").should route_to("group_buy_ins#new")
    end

    it "routes to #show" do
      get("/group_buy_ins/1").should route_to("group_buy_ins#show", :id => "1")
    end

    it "routes to #edit" do
      get("/group_buy_ins/1/edit").should route_to("group_buy_ins#edit", :id => "1")
    end

    it "routes to #create" do
      post("/group_buy_ins").should route_to("group_buy_ins#create")
    end

    it "routes to #update" do
      put("/group_buy_ins/1").should route_to("group_buy_ins#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/group_buy_ins/1").should route_to("group_buy_ins#destroy", :id => "1")
    end

  end
end
