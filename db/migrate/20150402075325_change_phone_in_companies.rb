class ChangePhoneInCompanies < ActiveRecord::Migration
  def change
    change_column :companies, :phone, :string
  end
end
