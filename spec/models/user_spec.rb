require 'rails_helper'

RSpec.describe User, :type => :model do
  it 'should return true if user admin' do
    user = create(:admin)
    expect(user).to be_admin
  end

  it 'should return true if user client' do
    user = create(:client)
    expect(user).to be_client
  end


end
