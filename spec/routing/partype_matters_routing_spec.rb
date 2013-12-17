require "spec_helper"

describe PartypeMattersController do
  describe "routing" do

    it "routes to #index" do
      get("partypes/1/matters").should route_to("partype_matters#index", :partype_id => "1")
    end

    it "routes to #new" do
      get("partypes/1/matters/new").should route_to("partype_matters#new", :partype_id => "1")
    end

    it "routes to #create" do
      post("partypes/1/matters").should route_to("partype_matters#create", :partype_id => "1")
    end

    it "routes to #destroy" do
      delete("partypes/1/matters/1").should route_to("partype_matters#destroy", :id => "1", :partype_id => "1")
    end

  end
end
