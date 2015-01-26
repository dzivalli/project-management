require 'rails_helper'

RSpec.describe SettingsController, :type => :controller do

  describe "GET general" do
    it "returns http success" do
      get :general
      expect(response).to be_success
    end
  end

  describe "GET email" do
    it "returns http success" do
      get :email
      expect(response).to be_success
    end
  end

end
