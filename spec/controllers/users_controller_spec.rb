require 'rails_helper'
RSpec.describe UsersController, type: :controller do
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assign all users as users" do
      users = FactoryGirl.create_list(:user, 3)
      get :index, {}, valid_session
      expect(assigns(:users)).to eq(users)
    end
  end

  describe "GET #show" do
    it "assign the requested user as @user" do
      user = FactoryGirl.create(:user)
      get :show, {id: user.to_param}, valid_session
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "GET #new" do
    it "assign a new user as @user" do
      get :new, {}, valid_session
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "POST #create" do
  	context "with valid params" do
  	  it "creates a new user" do
  	  	expect {
  	  		post :create, { user: FactoryGirl.attributes_for(:user)}, valid_session 
  	  	}.to change(User, :count).by(1)
  	  end

      it "with invalid params" do
      	user_params = FactoryGirl.attributes_for(:user)
      	user_params[:username] = "word1 word2"
        post :create, {user: user_params}, valid_session
        expect(assigns(:user)).to be_a_new(User)
        expect(assigns(:user).errors.empty?).to_not be true
      end  
    end
  end
end