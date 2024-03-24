module Mutations
  class UpdateUser < BaseMutation
    argument :id, ID, required: true
    argument :email, String, required: false
    argument :password, String, required: false
    argument :role, Types::RoleEnumType, required: false
    argument :first_name, String, required: false
    argument :middle_name, String, required: false
    argument :last_name, String, required: false
    argument :citizenship_number, String, required: false
    argument :permanent_address, String, required: false
    argument :temporary_address, String, required: false
    argument :contact_number, String, required: false

    field :user, Types::UserType, null: false
    field :errors, [String], null: false

    def resolve(id:, **attributes)
      user = User.find(id)

      if user.update(attributes)
        { user: user, errors: [] }
      else
        { user: nil, errors: user.errors.full_messages }
      end
    end
  end
end
