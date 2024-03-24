# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :reset_password, mutation: Mutations::ResetPassword
    field :loginUser, mutation: Mutations::LoginUser
    field :delete_user, mutation: Mutations::DeleteUser
    field :update_user, mutation: Mutations::UpdateUser
    field :create_user, mutation: Mutations::CreateUser



    
    field :test_field, String, null: false,
      description: "Insurance Management System"
    def test_field
      "Insurance Management System"
    end
  end
end
