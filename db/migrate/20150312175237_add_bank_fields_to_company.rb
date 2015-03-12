class AddBankFieldsToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :kpp, :string
    add_column :companies, :inn, :string
    add_column :companies, :bank_title, :string
    add_column :companies, :bik, :string
    add_column :companies, :schet, :string
    add_column :companies, :kor_schet, :string
  end
end
