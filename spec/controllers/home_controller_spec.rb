require 'rails_helper'

RSpec.describe HomeController, :type => :controller do

  describe 'login as admin' do
    login

    describe "GET index" do
      it "returns http success" do
        get :index
        expect(response).to be_success
      end
    end

  end

end
