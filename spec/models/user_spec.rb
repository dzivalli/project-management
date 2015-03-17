require 'rails_helper'

RSpec.describe User, :type => :model do
  it '.admin?' do
    let(:user) { create(:admin) }

    expect(user).to be_admin
  end

  it '.root?' do
    let(:user) { create(:root) }

    expect(user).to be_root
  end

  it '.staff?' do
    let(:user) { create(:staff) }

    expect(user).to be_staff
  end

  it '.customer?' do
    let(:user) { create(:customer) }

    expect(user).to be_customer
  end


end
