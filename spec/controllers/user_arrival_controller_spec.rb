require 'rails_helper'
RSpec.describe UserArrivalsController, type: :controller do

  let(:valid_session) { {} }
  describe "GET #index" do
    it "assign all user_arrivals as @user_arrivals" do
      user_arrival = FactoryGirl.create_list(:user_arrival, 3)
      get :index, {}, valid_session
    end
  end

  describe "POST #create" do
    before :each do
      @user = FactoryGirl.create(:user)
    end

    context "with valid params" do
    	it "creates a new UserArrival" do
        expect {
        	post :create, { username: @user.username}, valid_session
        }.to change(UserArrival, :count).by(1)
      end

      it "create with invalid params" do
      	post :create, {username: "dfsdf sdfdsf"}, valid_session
      	expect(assigns(:user_arrival).errors.empty?).to_not be true
      end
    end
  end
end