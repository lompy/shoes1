require "spec_helper"

describe PartsController do
  describe "routing" do

    it "routes to #index" do
      get("shoes/1/parts").should route_to("parts#index", :shoe_id => "1")
    end

    it "routes to #new" do
      get("shoes/1/parts/new").should route_to("parts#new", :shoe_id => "1")
    end

    it "routes to #show" do
      get("shoes/1/parts/1").should route_to("parts#show", :id => "1", :shoe_id => "1")
    end

    it "routes to #edit" do
      get("shoes/1/parts/1/edit").should route_to("parts#edit", :id => "1", :shoe_id => "1")
    end

    it "routes to #create" do
      post("shoes/1/parts").should route_to("parts#create", :shoe_id => "1")
    end

    it "routes to #update" do
      put("shoes/1/parts/1").should route_to("parts#update", :id => "1", :shoe_id => "1")
    end

    it "routes to #destroy" do
      delete("shoes/1/parts/1").should route_to("parts#destroy", :id => "1", :shoe_id => "1")
    end

  end
end
