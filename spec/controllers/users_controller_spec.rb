require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  before :each do
    @user1 = create(:user)
    @client1 = create(:client, owner: @user1)
    @customer1 = create(:user)
    @client1.users << @customer1

    user2 = create(:user)
    client1 = create(:client, owner: user2)
    @customer2 = create(:user)
    client1.users << @customer2



    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in @user1
  end


  context 'get index' do
    it 'should return only users belongs to current client' do
      client = double(@client1, owner: @user1)
      # puts client.owner.inspect
      # abort
      get :index

      expect(response).to be 200
      expect(:users.count).to eq(1)
    end
  end

end
