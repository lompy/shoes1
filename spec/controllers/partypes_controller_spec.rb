require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe PartypesController do

  # This should return the minimal set of attributes required to create a valid
  # Partype. As you add validations to Partype, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "name" => "MyString" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PartypesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all partypes as @records" do
      Partype.all.each{|p| p.destroy}
      partype = Partype.create! valid_attributes
      get :index, {}, valid_session
      assigns(:records).should eq([partype])
    end
  end

  describe "GET show" do
    it "assigns the requested partype as @record" do
      partype = Partype.create! valid_attributes
      get :show, {:id => partype.to_param}, valid_session
      assigns(:record).should eq(partype)
    end
  end

  describe "GET new" do
    it "assigns a new partype as @record" do
      get :new, {}, valid_session
      assigns(:record).should be_a_new(Partype)
    end
  end

  describe "GET edit" do
    it "assigns the requested partype as @record" do
      partype = Partype.create! valid_attributes
      get :edit, {:id => partype.to_param}, valid_session
      assigns(:record).should eq(partype)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Partype" do
        expect {
          post :create, {:partype => valid_attributes}, valid_session
        }.to change(Partype, :count).by(1)
      end

      it "assigns a newly created partype as @record" do
        post :create, {:partype => valid_attributes}, valid_session
        assigns(:record).should be_a(Partype)
        assigns(:record).should be_persisted
      end

      it "redirects to the created partype" do
        post :create, {:partype => valid_attributes}, valid_session
        response.should redirect_to(Partype.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved partype as @record" do
        # Trigger the behavior that occurs when invalid params are submitted
        Partype.any_instance.stub(:save).and_return(false)
        post :create, {:partype => { "name" => "invalid value" }}, valid_session
        assigns(:record).should be_a_new(Partype)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Partype.any_instance.stub(:save).and_return(false)
        post :create, {:partype => { "name" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested partype" do
        partype = Partype.create! valid_attributes
        # Assuming there are no other partypes in the database, this
        # specifies that the Partype created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Partype.any_instance.should_receive(:update).with({ "name" => "MyString" })
        put :update, {:id => partype.to_param, :partype => { "name" => "MyString" }}, valid_session
      end

      it "assigns the requested partype as @record" do
        partype = Partype.create! valid_attributes
        put :update, {:id => partype.to_param, :partype => valid_attributes}, valid_session
        assigns(:record).should eq(partype)
      end

      it "redirects to the partype" do
        partype = Partype.create! valid_attributes
        put :update, {:id => partype.to_param, :partype => valid_attributes}, valid_session
        response.should redirect_to(partype)
      end
    end

    describe "with invalid params" do
      it "assigns the partype as @record" do
        partype = Partype.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Partype.any_instance.stub(:save).and_return(false)
        put :update, {:id => partype.to_param, :partype => { "name" => "invalid value" }}, valid_session
        assigns(:record).should eq(partype)
      end

      it "re-renders the 'edit' template" do
        partype = Partype.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Partype.any_instance.stub(:save).and_return(false)
        put :update, {:id => partype.to_param, :partype => { "name" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested partype" do
      partype = Partype.create! valid_attributes
      expect {
        delete :destroy, {:id => partype.to_param}, valid_session
      }.to change(Partype, :count).by(-1)
    end

    it "redirects to the partypes list" do
      partype = Partype.create! valid_attributes
      delete :destroy, {:id => partype.to_param}, valid_session
      response.should redirect_to(partypes_url)
    end
  end

  describe "GET select" do
    it "assigns all partypes to @records" do
      Partype.destroy_all
      partype = Partype.create! valid_attributes
      get :select, {shoe_id: 1, part_id: 1}, valid_session
      assigns(:records).should eq([partype])
    end

    it "assigns @selet to params" do
      get :select, {shoe_id: 1, part_id: 1}, valid_session
      assigns(:select).should eq(part_id: "1")
    end
  end
end
