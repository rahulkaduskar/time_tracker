require 'rails_helper'
RSpec.describe 'users/index', type: :view do
  before(:each) do
  	@users = FactoryGirl.create_list(:user, 2)
  end

  it 'renders a list of users' do
  	render
  	expect(rendered).to match(/#{@users.first.username}/)
  end

end