class AddFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :middle_name, :string
    add_column :users, :last_name, :string
    add_column :users, :citizenship_number, :string
    add_column :users, :permanent_address, :string
    add_column :users, :temporary_address, :string
    add_column :users, :contact_number, :string
  end
end
