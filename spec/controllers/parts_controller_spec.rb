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

describe PartsController do

  # This should return the minimal set of attributes required to create a valid
  # Part. As you add validations to Part, be sure to
  # adjust the attributes here as well.
  let(:partype){ Partype.create!(name: 'partype_name') }
  let(:shoe){ Shoe.create!(name: 'shoe_name') }
  let(:valid_shoe_attribs){ {name: 'shoe_name'} }
  let(:valid_part_attribs){ {shoe_id: shoe.id, partype_id: partype.id} }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PartsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all parts as @records" do
      part = Part.create!(valid_part_attribs)
      get :index, { shoe_id: shoe.id}, valid_session
      assigns(:records).should eq([part])
    end
    it "does not assign parts as @records with wrong shoe_id" do
      Part.create!(valid_part_attribs)
      get :index, { shoe_id: shoe.id + 1}, valid_session
      assigns(:records).should eq([])
    end
  end

  describe "GET show" do
    it "assigns the requested part as @record" do
      part = Part.create!(valid_part_attribs)
      get :show, {shoe_id: 1, id: part.to_param}, valid_session
      assigns(:record).should eq(part)
    end
  end

  describe "GET new" do
    it "assigns a new part as @record" do
      get :new, { shoe_id: "1" }, valid_session
      assigns(:record).should be_a_new(Part)
    end

    it "assigns new part's shoe_id properly" do
      get :new, { shoe_id: "1" }, valid_session
      assigns(:record).shoe_id.should eq(1)
    end

    it "assigns @selected if params are passed" do
      matter = Matter.create!(name: 'matter_name')
      get :new, {shoe_id: shoe.id,
                 part: {partype_id: partype.id, matter_id: matter.id}}, valid_session
      assigns(:selected).should include(partype)
      assigns(:selected).should include(matter)
    end
  end

  describe "GET edit" do
    it "assigns the requested part as @record" do
      part = Part.create!(valid_part_attribs)
      get :edit, {shoe_id: shoe.id, :id => part.to_param}, valid_session
      assigns(:record).should eq(part)
    end

    it "assigns @selected if params are passed" do
      part = Part.create!(valid_part_attribs)
      matter = Matter.create!(name: 'matter_name')
      get :edit, {shoe_id: shoe.id, id: part.id,
                  part: {partype_id: partype.id, matter_id: matter.id}}, valid_session
      assigns(:selected).should include(partype)
      assigns(:selected).should include(matter)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Part" do
        expect {
          post :create, {shoe_id: shoe.id, :part => valid_part_attribs}, valid_session
        }.to change(Part, :count).by(1)
      end

      it "redirects to the created part" do
        post :create, {shoe_id: shoe.id, :part => valid_part_attribs}, valid_session
        response.should redirect_to('/shoes/' + shoe.id.to_s + '/parts/' + Part.last.id.to_s)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved part as @record" do
        # Trigger the behavior that occurs when invalid params are submitted
        Part.any_instance.stub(:save).and_return(false)
        post :create, {shoe_id: shoe.id, :part => {shoe_id: 'invalid'}}, valid_session
        assigns(:record).should be_a_new(Part)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Part.any_instance.stub(:save).and_return(false)
        post :create, {shoe_id: shoe.id, :part => {shoe_id: 'invalid'}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested part" do
        part = Part.create!(valid_part_attribs)
        # Assuming there are no other parts in the database, this
        # specifies that the Part created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Part.any_instance.should_receive(:update).with({ "shoe" => "" })
        put :update, {shoe_id: shoe.id, id: part.id, :part => { "shoe" => "" }}, valid_session
      end

      it "assigns the requested part as @record" do
        part = Part.create!(valid_part_attribs)
        put :update, {shoe_id: shoe.id, id: part.id, :part => valid_part_attribs}, valid_session
        assigns(:record).should eq(part)
      end

      it "redirects to the part" do
        part = Part.create!(valid_part_attribs)
        put :update, {shoe_id: shoe.id, id: part.id, :part => valid_part_attribs}, valid_session
        response.should redirect_to('/shoes/' + shoe.id.to_s + '/parts/' + part.id.to_s)
      end
    end

    describe "with invalid params" do
      it "assigns the part as @record" do
        part = Part.create!(valid_part_attribs)
        # Trigger the behavior that occurs when invalid params are submitted
        Part.any_instance.stub(:save).and_return(false)
        put :update, {shoe_id: 1, id: part.id, part: {shoe_id: "invalid"}}, valid_session
        assigns(:record).should eq(part)
      end

      it "re-renders the 'edit' template" do
        part = Part.create!(valid_part_attribs)
        # Trigger the behavior that occurs when invalid params are submitted
        Part.any_instance.stub(:save).and_return(false)
        put :update, {shoe_id: shoe.id, id: part.id, part: {shoe_id: "invalid"}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested part" do
      part = Part.create!(valid_part_attribs)
      expect {
        delete :destroy, {shoe_id:shoe.id, id: part.id}, valid_session
      }.to change(Part, :count).by(-1)
    end

    it "redirects to the parts list" do
      part = Part.create!(valid_part_attribs)
      delete :destroy, {shoe_id:shoe.id, id: part.id}, valid_session
      response.should redirect_to(shoe_parts_url(shoe.id))
    end
  end

end