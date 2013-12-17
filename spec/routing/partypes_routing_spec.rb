require "spec_helper"

describe PartypesController do
  describe "routing" do

    it "routes to #index" do
      get("/partypes").should route_to("partypes#index")
    end

    it "routes to #new" do
      get("/partypes/new").should route_to("partypes#new")
    end

    it "routes to #show" do
      get("/partypes/1").should route_to("partypes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/partypes/1/edit").should route_to("partypes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/partypes").should route_to("partypes#create")
    end

    it "routes to #update" do
      put("/partypes/1").should route_to("partypes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/partypes/1").should route_to("partypes#destroy", :id => "1")
    end

    it "routes to #select" do
      expect(get("/shoes/1/parts/1/select_partype")).to route_to("partypes#select", :shoe_id => "1", :part_id => "1")
    end

  end
end
