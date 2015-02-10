require 'rails_helper'

RSpec.describe ProjectsController, :type => :controller do


  context 'version' do
    before :all do
      @current_user = create(:admin, username: 'admin', id: 1)
      PaperTrail.whodunnit='1'
    end

    it 'should have 1 version after creating new project' do
      project = create(:project)
      versions = PaperTrail::Version.where(item_type: 'Project')
      expect(versions.count).to eq(1)
      expect(versions.last.whodunnit).to eq('1')
    end
  end


  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to be_success
    end


  end
  #
  # describe "GET show" do
  #   it "returns http success" do
  #     get :show
  #     expect(response).to be_success
  #   end
  # end
  #
  # describe "GET new" do
  #   it "returns http success" do
  #     get :new
  #     expect(response).to be_success
  #   end
  # end
  #
  # describe "GET create" do
  #   it "returns http success" do
  #     get :create
  #     expect(response).to be_success
  #   end
  # end
  #
  # describe "GET edit" do
  #   it "returns http success" do
  #     get :edit
  #     expect(response).to be_success
  #   end
  # end
  #
  # describe "GET update" do
  #   it "returns http success" do
  #     get :update
  #     expect(response).to be_success
  #   end
  # end
  #
  # describe "GET delete" do
  #   it "returns http success" do
  #     get :delete
  #     expect(response).to be_success
  #   end
  # end
  #
  #

end
