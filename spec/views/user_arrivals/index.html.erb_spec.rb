require 'rails_helper'

RSpec.describe "user_arrivals/index", type: :view do
  before(:each) do
    @user_arrivals = FactoryGirl.create_list(:user_arrival, 2)
  end

  it "renders a list of arrivals" do
    render
    expect(rendered).to match(/#{@user_arrivals.first.user.username}/)
  end
end